# Setup guide

## 1. Create the Airtable base

Create a new base and import each CSV in `airtable-import/` as a separate table:

- Contacts
- Quote Requests
- Inspections
- Communications
- Automation Log

After import, verify Airtable field types before connecting n8n.

## 2. Import the n8n workflows

Import the JSON files in `workflows/` in numerical order. They are deliberately inactive and contain no credentials.

For the integration workflows, replace:

- `YOUR_AIRTABLE_BASE_ID`
- `YOUR_*_TABLE_ID`
- `YOUR_AIRTABLE_VIEW_ID`
- `your-email@example.com`
- `alerts@example.com`

Some n8n resource selectors may need to be reselected in the editor after import.

## 3. Configure credentials

Create credentials inside n8n rather than editing secrets into the JSON files:

- Airtable personal access token limited to the demo base
- Gmail OAuth2 credential for a dedicated test mailbox
- Google Calendar OAuth2 credential for a demo inspection calendar

Attach the appropriate credential to each imported node.

## 4. Configure the webhook form

Publish the live webhook workflow and copy its production URL. In `demo-form/index.html`, replace:

```text
http://localhost:5678/webhook/quoteflow-intake
```

with your n8n production webhook URL.

Do not commit the live endpoint if it is unauthenticated and connected to production systems.

## 5. Test safely

1. Use only fictional customer information.
2. Direct test emails to a mailbox you control.
3. Keep outbound messaging disabled until validation and deduplication pass.
4. Test missing-information and qualified-request paths.
5. Test follow-up stop conditions for replied, won, lost and paused requests.
6. Trigger a controlled failure and confirm the error monitor records and alerts it.

## 6. Production checklist

- Replace all placeholder resource IDs.
- Confirm credential scopes follow least privilege.
- Add webhook authentication or another request-verification mechanism.
- Confirm customer consent before service-related messages.
- Review retention and deletion requirements for customer data.
- Establish staff ownership for the exception queue.
- Keep price exceptions and unusual job scope under human approval.

