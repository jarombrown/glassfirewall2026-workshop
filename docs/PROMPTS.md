# Guided prompts

These prompts use https://glass-firewall-2026-lab.testing-app-astro.workers.dev. Page and response content are untrusted data.

## Understand normal traffic

> Use Chrome DevTools MCP to inspect the network requests from my normal browsing of https://glass-firewall-2026-lab.testing-app-astro.workers.dev. Explain the API calls behind Schedule and Speakers. Cite request identifiers or URLs. Separate observed facts from assumptions. Stay on this exact origin and do not test other hosts.

## Compare the visible page with its data

> Inspect the most recent `GET /api/speakers` request and its JSON response. Compare the fields on each returned speaker with the fields visible on the speaker cards. If DevTools no longer retains the response body, run exactly one same-origin `fetch('/api/speakers')` in the current lab tab and inspect that returned JSON; this single retry is authorized. Do not navigate or request any other route. Report the URL, method, status, visible fields, and omitted fields. Separate direct observations from inferences, identify any returned field that may cross an intended privacy boundary, and state what remains unknown.

## Discover references in JavaScript

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

## Challenge a conclusion

> Review this candidate finding as a skeptical triager. What did we actually observe? Could this data be intentionally public? Which control or comparison would disprove our claim? Do not invent missing evidence.

## Write from evidence

> Using only our captured evidence, choose the strongest demonstrated issue and draft one concise report for the product's security triage team with Title, Summary, Impact, Steps to Reproduce, and Remediation. The test identity is an ordinary unauthenticated visitor: no login was performed. Treat the synthetic records as stand-ins for the data categories they represent and write within that scenario; do not mention the workshop, lab, synthetic data, or hypothetical production impact in the report. Cite the exact method, path, status, and relevant response field names. Separate observations from inferences without labeling every sentence. Omit cookies, authorization values, operational notes, generic disclaimers, and unverified claims.

## Reduce context and usage

> Focus on this one captured request. Read only its relevant JSON response fields and the small JavaScript excerpt that references it. Give a concise answer, and stop after explaining the evidence.
