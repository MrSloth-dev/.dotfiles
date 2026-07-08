import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const sessionReasons = new Set(["startup", "resume", "clear", "compact"] as const);
const discoveryTools = new Set(["grep", "find"]);

let discoveryGateUsed = false;

export default function (pi: ExtensionAPI) {
  pi.on("session_start", async (event, ctx) => {
    discoveryGateUsed = false;

    if (sessionReasons.has(event.reason)) {
      ctx.ui.notify(
        [
          "CRITICAL - Code Discovery Protocol:",
          "1. ALWAYS use codebase-memory-mcp tools FIRST for ANY code exploration:",
          "   - search_graph(name_pattern/label/qn_pattern) to find functions/classes/routes",
          "   - trace_path(function_name, mode=calls|data_flow|cross_service) for call chains",
          "   - get_code_snippet(qualified_name) to read source (NOT Read/cat)",
          "   - query_graph(query) for complex Cypher patterns",
          "   - get_architecture(aspects) for project structure",
          "   - search_code(pattern) for text search (graph-augmented grep)",
          "2. Fall back to Grep/Glob/Read only for text content, config values, non-code files.",
          "3. If a project is not indexed yet, run index_repository FIRST.",
        ].join("\n"),
        "info",
      );
    }
  });

  pi.on("tool_call", async (event) => {
    if (discoveryGateUsed) return;

    if (discoveryTools.has(event.toolName)) {
      discoveryGateUsed = true;
      return {
        block: true,
        reason:
          "BLOCKED: For code discovery, use codebase-memory-mcp tools first: search_graph(name_pattern) to find functions/classes, trace_path() for call chains, get_code_snippet() to read source. If the graph is not indexed yet, call index_repository first. Fall back to grep/find only for text content search. If you need grep/find, retry.",
      };
    }
  });
}
