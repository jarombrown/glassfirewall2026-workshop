# Glass Firewall 2026 · AI-assisted hacking

Participant guide for a 45-minute introductory browser-security workshop.

## Workshop lab

Open **[glass-firewall-2026-lab.testing-app-astro.workers.dev](https://glass-firewall-2026-lab.testing-app-astro.workers.dev)**.

This is an authorized practice environment containing intentional security defects and synthetic records. Test only this exact origin. The conference website, Cloudflare infrastructure, GitHub, AI providers, and other participants' devices are outside the exercise.

## Install Chrome DevTools MCP before starting the agent

Complete the [participant setup](docs/SETUP.md) before starting a session with an agent.

1. Open this guide folder in VS Code.
2. Open `.vscode/mcp.json` and install/start the `chrome-devtools` server. The first start installs the pinned Chrome DevTools MCP package through `npx`.
3. Wait until VS Code shows the MCP server as running.
4. Only after the server is running, open Copilot Chat and start an agent session with tools enabled.

Use the Chrome window opened by MCP for all workshop browsing. Open DevTools with Command+Option+I on macOS or Ctrl+Shift+I on Windows/Linux. Select Network and enable Preserve log.

## Walkthrough and prompt cheat sheet

Give the agent these prompts in order. Read each response and confirm that the evidence supports it before continuing.

### 1. How do I get the agent to open a browser?

<details>
<summary>Show the exact prompt</summary>

> This is an authorized training lab. Use Chrome DevTools MCP to open https://glass-firewall-2026-lab.testing-app-astro.workers.dev and select that tab. Stay on this exact origin. Do not test other hosts or edit the app. Tell me when the page is ready, then stop.

</details>

### 2. What requests loaded with the page?

<details>
<summary>Show the exact prompt</summary>

> Reload the selected lab tab and list the network requests captured by Chrome DevTools MCP. Identify the request that loads the schedule. Give me its URL, method, status, and the top-level response fields. Do not make any new requests yet.

</details>

### 3. Does the Speakers page receive more data than it displays?

In the MCP-managed Chrome window, select **Speakers** before sending this prompt.

<details>
<summary>Show the exact prompt</summary>

> Inspect the most recent `GET /api/speakers` request and its JSON response. Compare the fields on each returned speaker with the fields visible on the speaker cards. If DevTools no longer retains the response body, run exactly one same-origin `fetch('/api/speakers')` in the current lab tab and inspect that returned JSON; this single retry is authorized. Do not navigate or request any other route. Report the URL, method, status, visible fields, and omitted fields. Separate direct observations from inferences, and identify any returned fields that may cross an intended privacy boundary.

</details>

### 4. Does the browser's JavaScript reference other features?

<details>
<summary>Show the exact prompt</summary>

> Act as a curious, evidence-driven web security researcher. Use Chrome DevTools to:
>
> 1. List the JavaScript loaded by this lab.
> 2. Search it for API paths, route definitions, network calls, and references to lazy-loaded chunks.
> 3. Retrieve and inspect any referenced JavaScript chunks from this same origin.
> 4. Compare the same-origin `/api/` routes you find with the captured network requests, then list the routes normal browsing has not used.
>
> Retrieving same-origin static JavaScript for source inspection is authorized. Do not call a new API yet.
>
> For each route, cite the source file or relevant code and explain what feature it suggests. Clearly separate observations from inferences: a route name or client-side reference alone is not proof of a vulnerability. Select the strongest candidate, state the exact read-only GET request you propose and what security question it would answer, then stop and wait for my approval before sending that API request.

</details>

### 5. How do I approve one bounded check?

This check uses the legacy attendee route discovered in the lab's JavaScript.

<details>
<summary>Show the exact prompt</summary>

> Approved: make one GET request to `https://glass-firewall-2026-lab.testing-app-astro.workers.dev/api/legacy/v1/attendees`. Capture the status and relevant response fields. Do not enumerate routes, follow links to another host, or make additional requests. Explain what this response establishes and what it does not establish.

</details>

### 6. What evidence could weaken the conclusion?

<details>
<summary>Show the exact prompt</summary>

> Act as a skeptical security triager. Using only the requests and responses we captured, identify an alternative explanation or a useful protected comparison. If another request is needed, propose exactly one same-origin GET request and wait for approval. Do not invent evidence.

</details>

### 7. How do I turn the evidence into a finding?

Use the [finding worksheet](docs/FINDING-WORKSHEET.md) for your notes.

<details>
<summary>Show the exact prompt</summary>

> Using only our captured evidence, choose the strongest demonstrated issue and draft one concise report for the product's security triage team with Title, Summary, Impact, Steps to Reproduce, and Remediation. The test identity is an ordinary unauthenticated visitor: no login was performed. Treat the synthetic records as stand-ins for the data categories they represent and write within that scenario; do not mention the workshop, lab, synthetic data, or hypothetical production impact in the report. Cite the exact method, path, status, and relevant response field names. Separate observations from inferences without labeling every sentence. Omit cookies, authorization values, operational notes, generic disclaimers, and unverified claims.

</details>

### 8. Is the finding ready to share?

<details>
<summary>Show the exact prompt</summary>

> Review the draft as a skeptical security triager. Remove unsupported claims, duplicate wording, hedging that obscures demonstrated impact, and internal workflow notes. Confirm that every impact statement follows from the captured response. Preserve the scenario's framing: do not add workshop, lab, synthetic-data, or hypothetical-production disclaimers. Return only the revised report.

</details>

For a shorter timed version, follow the [15-minute exercise](docs/EXERCISE.md). The [guided prompts](docs/PROMPTS.md) are available separately. If MCP or AI access fails, pair up or use the [browser-only fallback](docs/FALLBACK.md).

## Evidence rules

- Separate observations from hypotheses.
- Cite the request, response status, relevant fields, and test identity.
- A route name or client-side reference is not proof of a vulnerability.
- Ask before making a new request suggested by discovered JavaScript.
- Do not include cookies, authorization values, or personal account information in a report.

## References

- [Actual Glass Firewall 2026 event](https://h1.community/events/details/hackerone-diversity-and-inclusion-di-presents-2026-glass-firewall-conference-breaking-bytes-and-barriers/)
- [Chrome DevTools MCP](https://github.com/ChromeDevTools/chrome-devtools-mcp)
- [MCP in VS Code](https://code.visualstudio.com/docs/agent-customization/mcp-servers)
- [GitHub Copilot plans](https://docs.github.com/en/copilot/get-started/plans)

The practice portal is not an official conference or registration website. Its people, records, preview keys, and contact details are synthetic.
