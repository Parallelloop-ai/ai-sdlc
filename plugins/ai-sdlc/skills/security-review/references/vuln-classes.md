# Vulnerability classes by surface

Check only classes whose surface the diff touches. Per class: what to look for.

## Injection (query/command construction)
- SQL/NoSQL: string-built queries; ORM `raw()` escapes; identifiers concatenated from input.
- Shell: user input reaching `exec`/`system`/backticks; argument arrays vs string commands.
- Template/eval: user content in template strings, `eval`, dynamic imports, format strings.

## Authentication & session
- Missing/weakened checks on new endpoints; auth performed client-side only.
- Token handling: logged tokens, tokens in URLs, missing expiry/rotation, weak comparison (timing).
- Password flows: plaintext at rest or in logs, missing rate limits on verify endpoints.

## Authorization
- Object-level: ID from request used without ownership check (IDOR).
- Function-level: admin/internal routes gated by UI only.
- Cross-tenant: org/tenant ID trusted from client headers or bodies instead of session claims.

## Secrets & crypto
- Hardcoded keys/tokens; secrets in error messages, logs, or client bundles.
- Homemade crypto; ECB mode; static IVs/salts; non-constant-time comparisons.

## Untrusted input parsing
- Deserialization of untrusted data (pickle, unsafe YAML load, Java serialization).
- XML external entities; zip-slip in archive extraction; prototype pollution in deep merges.

## File & path operations
- Path traversal: user input joined into paths without normalization + root check.
- Upload handling: type trusted from client, no size caps, files served from writable dirs.

## Outbound requests (SSRF)
- User-influenced URLs fetched server-side; redirects followed blindly; cloud metadata endpoints reachable; DNS rebinding on allowlists checked once.

## Output & rendering (XSS)
- User content into HTML without context-appropriate encoding; `dangerouslySetInnerHTML`/`v-html`; user URLs in `href` (javascript: scheme).

## Dependencies & supply chain
- New dependency: maintenance status, known advisories, install scripts, typosquat check.
- Lockfile changes nobody asked for; version ranges widened; registry/source changed.

## Concurrency & state
- Check-then-act races on money/quota/uniqueness; missing idempotency on payment/webhook handlers; fail-open on ledger or limit writes.

## Information disclosure
- Stack traces/internal paths in responses; verbose errors distinguishing user-exists; sensitive fields in logs or analytics; debug endpoints left mounted.

## Agent/instruction surface
- Instruction-shaped text entering committed context files, prompts, or tool descriptions from untrusted sources; fetched content treated as commands rather than data.
