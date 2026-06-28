# OpenCode API How-To

This guide describes how to interact with the OpenCode Server API using the session-based workflow.

## Workflow Overview
The OpenCode API requires a two-step process: first creating a session to maintain context, and then sending messages to that specific session.

---

## Step 1: Create a Session
Before sending any prompts, you must initialize a session. This returns a `sessionId` which must be used for all subsequent messages in that conversation.

### Request
**Endpoint:** `POST /session`  
**Body:** `{}` (Empty JSON object)

### Example (cURL)
```bash
curl -X POST http://localhost:4096/session \
     -H "Content-Type: application/json" \
     -d '{}'
```

### Response
```json
{
  "id": "sess_12345abcde"
}
```

---

## Step 2: Send a Message
Use the `id` received from the session creation to send your prompt.

### Request
**Endpoint:** `POST /session/{sessionId}/message`  
**Body:** A JSON object containing a `parts` array.

### Example (cURL)
```bash
curl -X POST http://localhost:4096/session/sess_12345abcde/message \
     -H "Content-Type: application/json" \
     -d '{
       "parts": [
         {
           "type": "text",
           "text": "Hello! What is the capital of Denmark?"
         }
       ]
     }'
```

### Response
```json
{
  "parts": [
    {
      "type": "text",
      "text": "The capital of Denmark is Copenhagen."
    }
  ]
}
```

### virkeligt eksempel

```bash
# get session
curl -X POST http://localhost:4096/session \
     -H "Content-Type: application/json" \
     -d '{}'

# session is returned from opencode : "id":"ses_21c9f760dffeGrzy4c05Yb0Qdy"   

{"id":"ses_21c9f760dffeGrzy4c05Yb0Qdy","slug":"playful-wizard","version":"1.3.15","projectID":"global","directory":"/","title":"New session - 2026-05-01T11:50:48.051Z","time":{"created":1777636248051,"updated":1777636248051}}

# use session
curl -X POST http://localhost:4096/session/ses_21c9f760dffeGrzy4c05Yb0Qdy/message \
     -H "Content-Type: application/json" \
     -d '{
       "parts": [
         {
           "type": "text",
           "text": "hvad er 2+2?, svar kun med tal"
         }
       ]
     }'

# 2+2 = The answer is simply 4

{"info":{"parentID":"msg_de361fcb9001wCBKSV4tgTwk0j","role":"assistant","mode":"build","agent":"build","path":{"cwd":"/","root":"/"},"cost":0,"tokens":{"total":11469,"input":9647,"output":30,"reasoning":0,"cache":{"write":0,"read":1792}},"modelID":"big-pickle","providerID":"opencode","time":{"created":1777636342987,"completed":1777636347253},"finish":"stop","id":"msg_de361fccb001DSw7JMdkWYj5xP","sessionID":"ses_21c9f760dffeGrzy4c05Yb0Qdy"},"parts":[{"type":"step-start","id":"prt_de3620b16001WHqOq8B4W6xg9x","sessionID":"ses_21c9f760dffeGrzy4c05Yb0Qdy","messageID":"msg_de361fccb001DSw7JMdkWYj5xP"},{"type":"reasoning","text":"The user is asking \"what is 2+2?, answer only with numbers\" in Danish. The answer is simply 4","time":{"start":1777636346657,"end":1777636347201},"id":"prt_de3620b21001W6XiJJOdrQYOc8","sessionID":"ses_21c9f760dffeGrzy4c05Yb0Qdy","messageID":"msg_de361fccb001DSw7JMdkWYj5xP"},{"type":"text","text":"4","time":{"start":1777636347199,"end":1777636347199},"id":"prt_de3620d34001gwz5lHa5lLlb0f","sessionID":"ses_21c9f760dffeGrzy4c05Yb0Qdy","messageID":"msg_de361fccb001DSw7JMdkWYj5xP"},{"type":"reasoning","text":"","time":{"start":1777636347203,"end":1777636347205},"metadata":{"anthropic":{"redactedData":"openrouter.reasoning:eyJ0ZXh0IjoiVGhlIHVzZXIgaXMgYXNraW5nIFwid2hhdCBpcyAyKzI/LCBhbnN3ZXIgb25seSB3aXRoIG51bWJlcnNcIiBpbiBEYW5pc2guIFRoZSBhbnN3ZXIgaXMgc2ltcGx5IDQiLCJ0eXBlIjoicmVhc29uaW5nLnRleHQifQ=="}},"id":"prt_de3620d43001ZyjiHHdE2P0XvC","sessionID":"ses_21c9f760dffeGrzy4c05Yb0Qdy","messageID":"msg_de361fccb001DSw7JMdkWYj5xP"},{"reason":"stop","type":"step-finish","tokens":{"total":11469,"input":9647,"output":30,"reasoning":0,"cache":{"write":0,"read":1792}},"cost":0,"id":"prt_de3620d6e0012Nj5LC9t37rdWk","sessionID":"ses_21c9f760dffeGrzy4c05Yb0Qdy","messageID":"msg_de361fccb001DSw7JMdkWYj5xP"}]}

```

---

## Implementation Example (JavaScript)

```javascript
async function askOpenCode(prompt) {
    const baseUrl = "http://localhost:4096";

    // 1. Create Session
    const sessionRes = await fetch(`${baseUrl}/session`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({})
    });
    const { id: sessionId } = await sessionRes.json();

    // 2. Send Message
    const messageRes = await fetch(`${baseUrl}/session/${sessionId}/message`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            parts: [{ type: "text", text: prompt }]
        })
    });
    const data = await messageRes.json();
    
    return data.parts.find(p => p.type === 'text')?.text;
}
```
