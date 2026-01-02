  return {
    arduino_language_server = {
      cmd = {
        "arduino-language-server",
        "-cli-config", "/home/mrsloth/.arduino15/arduino-cli.yaml",
        "-cli", "arduino-cli",
        "-clangd", "clangd",
        "-fqbn", "arduino:avr:uno"
      },
      filetypes = { "arduino" },
      root_markers = { "*.ino", "sketch.yaml" },
    }
  }
