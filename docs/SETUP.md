# Participant setup

The lab is hosted. You do not need to download or run the website source.

1. Install Node.js 24 LTS, VS Code, and Google Chrome. Node supplies `npx`, which installs and starts the browser tool.
2. Sign in to GitHub Copilot in VS Code and confirm that your account has usage available, but do not start an agent session yet.
3. Download or clone this guide repository and open its folder in VS Code.
4. Open `.vscode/mcp.json` and install/start the `chrome-devtools` server. Accept the trust prompt for this workshop. The first start installs the pinned Chrome DevTools MCP package through `npx`.
5. Wait until VS Code shows the MCP server as running. Only after that installation is complete should you open Copilot Chat, select the agent experience, and confirm that the Chrome DevTools tools are enabled.
6. Follow the prompt walkthrough in the main README. Use the Chrome window opened by MCP for workshop browsing.

## Four things that prove readiness

- Copilot responds and your account has usage remaining.
- The Chrome DevTools MCP server starts and its tools appear.
- The agent opens the hosted lab in its Chrome window.
- The agent retrieves and explains a captured request.

Opening the site in your ordinary browser does not prove that MCP can see its traffic.

## Common problems

| Symptom | Recovery |
| --- | --- |
| `npx` is missing | Install Node.js 24 LTS, then restart VS Code |
| MCP cannot find Chrome | Install Google Chrome in its default location, then restart the MCP server |
| MCP tools are missing | Check the server trust/start status and the tools selector in chat |
| You browse but AI sees no requests | Use the MCP-managed Chrome window; ask it to select the lab tab and reload |
| The lab URL does not open | Confirm the full `https://` URL and ask the instructor to verify service status |
| AI reaches its allowance | Pair with another attendee or use the prepared fallback evidence |
| Organization policy prevents installation | Use the fallback during the session and complete setup later |

## Copilot access

Use the personal GitHub account you plan to use in VS Code. The instructor will provide any workshop-specific access instructions. Confirm that Copilot Chat responds before the exercise. If your account cannot use Copilot during the workshop, pair with another attendee or use the prepared fallback evidence. Do not share accounts.
