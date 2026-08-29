import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "omarchy.workspaces"

  function workspaceById(id) {
    var values = Hyprland.workspaces.values
    for (var i = 0; i < values.length; i++) {
      if (values[i].id === id) return values[i]
    }

    return null
  }

  // The Hyprland output this bar surface lives on. Empty until the Quickshell
  // window resolves; the bindings below re-evaluate once it does.
  readonly property string screenName: {
    var qw = root.QsWindow
    var win = qw ? qw.window : null
    var scr = win ? win.screen : null
    return scr && scr.name ? String(scr.name) : ""
  }

  // Only the workspaces that currently live on this monitor. A workspace's
  // monitor is whichever output it was opened on (plus each monitor's active
  // workspace, even when empty). Until screenName resolves, show everything.
  function workspaceIds() {
    var name = root.screenName
    var ids = []
    var values = Hyprland.workspaces.values

    for (var i = 0; i < values.length; i++) {
      var ws = values[i]
      var id = ws.id
      if (id <= 0 || id > 10) continue
      if (name !== "" && (!ws.monitor || ws.monitor.name !== name)) continue
      if (ids.indexOf(id) === -1) ids.push(id)
    }

    ids.sort(function(left, right) { return left - right })
    return ids
  }

  function focusWorkspace(id) {
    if (!root.bar) return
    root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"" + id + "\" })"))
  }

  readonly property real trailingGap: root.vertical ? 0 : Style.spaceReal(1.5)

  implicitWidth: grid.implicitWidth + trailingGap
  implicitHeight: grid.implicitHeight

  GridLayout {
    id: grid
    anchors.fill: parent
    anchors.rightMargin: root.trailingGap
    columns: root.vertical ? 1 : Math.max(1, root.workspaceIds().length)
    columnSpacing: root.vertical ? 0 : Style.space(1)
    rowSpacing: root.vertical ? Style.space(2) : 0

    Repeater {
      model: root.workspaceIds()

      WidgetButton {
        id: wsButton
        required property int modelData

        readonly property var workspace: root.workspaceById(modelData)
        readonly property bool occupied: workspace !== null && workspace.toplevels.values.length > 0
        readonly property bool focused: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === modelData

        bar: root.bar
        // Always show the number; mark the selected one with accent color + a pill outline.
        text: modelData === 10 ? "0" : String(modelData)
        active: focused
        opacity: occupied || focused ? 1 : 0.5
        horizontalMargin: 6
        verticalPadding: 6
        fixedWidth: root.vertical ? root.barSize : Style.space(20)
        fixedHeight: root.barSize
        onPressed: function() { root.focusWorkspace(modelData) }

        Rectangle {
          z: -1
          anchors.centerIn: parent
          width: (root.vertical ? root.barSize : Style.space(20)) - Style.space(3)
          height: root.barSize - Style.space(8)
          radius: height / 2
          color: "transparent"
          border.width: 1
          border.color: Color.accent
          visible: wsButton.focused
        }
      }
    }
  }
}
