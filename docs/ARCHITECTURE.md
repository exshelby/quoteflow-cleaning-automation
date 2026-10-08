# Architecture

QuoteFlow separates customer intake, operational state and communication into small workflows. This keeps the business logic understandable and makes failures easier to isolate.

## Systems

- **HTML form:** collects the customer and job information.
- **n8n:** validates data, routes work and coordinates integrations.
- **Airtable:** stores contacts, quote requests, inspections, communications and automation logs.
- **Gmail:** delivers acknowledgements, confirmations, follow-ups and staff alerts.
- **Google Calendar:** holds tentative inspection slots.

## Core records

### Contacts

One record per customer. Normalized email and phone fields support duplicate detection.

### Quote Requests

One record per requested job. It owns the pipeline stage, lead score, next action and follow-up controls.

### Inspections

Stores proposed dates, approval state, assigned staff and the calendar event reference.

### Communications

Records inbound and outbound messages, timestamps, delivery state and the related request.

### Automation Log

Records failed workflow executions, retry counts and diagnostic details.

## Pipeline

```text
New
  -> Awaiting Information
  -> Qualified
  -> Inspection Offered
  -> Awaiting Approval
  -> Inspection Scheduled
  -> Quote Sent
  -> Following Up
  -> Won / Lost / Paused
```

## Control principles

1. Validation happens before records or messages are created.
2. Every request receives a stable request ID.
3. Follow-ups use explicit due dates and stop conditions.
4. Replies are deduplicated before they update CRM state.
5. Calendar holds remain tentative until staff approval.
6. Failures are logged and surfaced for manual action.
7. Final pricing exceptions remain subject to human review.

