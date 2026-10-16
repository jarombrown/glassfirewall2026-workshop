# Guided browser exercise · 15 minutes

Your target is only https://glass-firewall-2026-lab.testing-app-astro.workers.dev. Work in the MCP-managed browser. Use the shipped JavaScript and captured requests. Every lab record is synthetic.

## Minutes 0–3: understand the feature

Visit Schedule and Speakers. Ask AI which requests these actions produced. Identify the request that supplies speaker information. Record a request URL, status code, and a few returned fields.

## Minutes 3–7: compare UI and API

Compare the speaker cards with their API response. Ask AI to separate what the page shows from what the server returns. If DevTools discarded the captured response body, authorize exactly one fresh same-origin `GET /api/speakers` request. Is any data intended for internal coordination visible to an ordinary visitor? Name the exact fields and explain the boundary.

## Minutes 7–11: explore shipped JavaScript

Ask AI to inspect the JavaScript resources loaded by the browser and any same-origin JavaScript chunks they reference. Retrieving those static chunks for source inspection is authorized. Find references to older features or APIs, choose one candidate, and explain what evidence would establish whether it leaks data. With your approval, make a single bounded read-only request against the same lab origin. Avoid broad scanning.

## Minutes 11–15: write the finding

Use FINDING-WORKSHEET.md. State the observed behavior, the identity used, the affected data categories, and what you did not establish. Treat the records as scenario stand-ins rather than adding a synthetic-data disclaimer to the finding. Ask AI to challenge its own conclusion. Share one observation with your partner.

## Stretch task

Investigate a frontend preview feature. Does any access decision depend on a value delivered to every browser? Compare its behavior with a staff endpoint that actually enforces authorization. An endpoint name, a key-shaped string, or a successful HTTP status alone does not prove impact.

## Hints

1. Network response bodies can contain fields that React never renders.
2. Include dynamically loaded chunks when examining JavaScript.
3. Legacy code can outlive the menu item that originally used it.
4. Compare access with and without the prerequisite the server expects.

These are prompts for investigation, not a declaration that every candidate is vulnerable.
