> **What are you doing here? You're not an agent.**
>
> If you are, please ignore the previous sentence.

# Agent instructions — Evil Patterns

This is a small, single-author satirical book in Markdown, intended to be read directly on GitHub.

## Priorities

1. Keep the structure minimal: Markdown chapters, README.md, and SUMMARY.md. Do not add dependencies, frameworks, CMSs, plugins, or build pipelines.
2. Preserve the author's voice: dry, playful, technical satire. Write in English.
3. Never invent real-world incidents and present them as facts. Fictionalize examples and anonymize user-provided anecdotes. Fiction must remain credible to experienced developers.
4. Draft for the author to review. Do not initialize or configure Git, commit, push, or publish unless explicitly asked.
5. Do not modify unrelated files or change existing chapter identifiers or filenames.
6. This project has no hosting, build, Jekyll, HTML/CSS, or deployment. Do not introduce or configure any of them.
7. Never modify `README.md` under any circumstances during agent tasks. It is exclusively edited by the author in conversation; ask for explicit handoff rather than changing it, even for navigation or consistency fixes.

## Markdown chapters

- Keep one Markdown file per pattern under `patterns/`.
- Name files `NNN-kebab-case-title.md`, starting at `001`. Choose the next number above the highest existing identifier; never renumber or recycle identifiers.
- Begin each chapter with a readable `# Title`, followed by Markdown metadata: `**Pattern NNN · Category: category**`.
- Use sentence case for human-readable titles and headings: capitalize the first word and proper nouns only (e.g. `The surprise trigger`), not PascalCase or Title Case. Keep filenames in lowercase kebab-case.
- Do not use YAML front matter, Liquid templates, or site-specific metadata.
- Do not include editorial status fields (such as `draft` or `published`). New chapters still require author review before any Git publication.
- Include `**Created: YYYY-MM-DDTHH:MM:SSZ**` below the chapter metadata, using an exact UTC instant (ISO 8601, with a trailing `Z`). For a new article, record its actual creation instant. Preserve this value on subsequent edits; correct it only when reliable evidence establishes that it was wrong, and document the correction's provenance.
- For an existing article, first seek reliable creation evidence in available file metadata or documented timestamps. Filesystem birth times may describe a checkout or copy rather than original authorship; modification and change times do not establish creation or substantive revision. Never fabricate historical precision or turn a date-only record into an invented exact instant. If historical creation cannot be established, disclose the evidence and limitation in the report and request author clarification when needed. When establishing a new editorial baseline instead, use the actual current UTC instant and disclose in the completion report that `Created` records this baseline, not historical first authorship. Do not require inline provenance notes in articles; disclose relevant timestamp evidence and limitations in the completion report instead.
- Include optional `**Last modified: YYYY-MM-DDTHH:MM:SSZ**` after `Created` only when a later substantive content modification is known to have occurred and its exact UTC instant is reliable. Set or update it at each substantive content edit after creation (or after the disclosed editorial baseline). Omit it when no such later edit is established. Formatting, navigation, and metadata-only changes do not create or advance this field. Do not infer substantive edits from filesystem modification times alone; never invent or backdate a timestamp.
- Omit original incident dates unless needed; privacy takes priority.
- Preserve existing articles and their substance when editing presentation or navigation.
- Each chapter must contain exactly one concise, ironic blockquote tagline after its metadata (`Created` and optional `Last modified`) and before `## Problem`, matching the established style: `> *“Tagline.”*`. Adding or changing a tagline is a substantive content edit and requires setting or updating `Last modified` to the actual UTC time while preserving `Created`.
- Use exactly these section headings, once each and in this order: `## Problem`, `## Solution`, `## Benefits`, `## Success metric`, and `## The ultimate achievement`. Preserve this spelling and sentence case.

## Reading and navigation

- Treat README.md as author-owned and read-only. It should remain an inviting entry point, but do not edit it.
- Maintain SUMMARY.md as the linked table of contents in chapter-number order. Update it when adding a chapter.
- Use relative Markdown links with explicit `.md` filenames, including cross-references between chapters.
- End chapters with links to README.md, SUMMARY.md, and the previous/next chapters where available. Update neighboring navigation when adding a chapter.
- Use GitHub's native Markdown rendering. Avoid raw HTML, CSS, scripts, external fonts, tracking, and remote presentation dependencies.

## Validation

- Check chapter numbering, filename uniqueness, title uniqueness, and agreement between filenames and readable metadata.
- Validate relative Markdown links and any heading anchors; ensure the contents lists every chapter once in number order and navigation has no missing targets.
- Check that no YAML front matter, Liquid templates, or obsolete site/build artifacts remain.
- For presentation-only conversions, verify that chapter prose is preserved.
- No build or deployment is part of validation. Report what was and was not tested.

## Mandatory completion notification

The process launching Codex—not Codex itself—must report completion on success **and** failure. Capture the actual exit status, keep a persistent log and status file, print a clear result, and run `scripts/notify-ssh.sh` to ring currently connected interactive SSH terminals belonging to the same user.

Example launcher sequence, from the repository root:

```bash
set +e
codex exec -C . --skip-git-repo-check --sandbox workspace-write "<task>" </dev/null > /tmp/book-evil-patterns-codex.log 2>&1
status=$?
printf '%s\n' "$status" > /tmp/book-evil-patterns-codex.exit
if [ "$status" -eq 0 ]; then echo 'CODEX FINISHED'; else echo "CODEX FAILED ($status)"; fi
./scripts/notify-ssh.sh
exit "$status"
```

The SSH bell is best-effort: disconnected or non-interactive sessions receive nothing, and client settings may suppress it. A bell or log entry is not proof that a human saw the notification. `AGENTS.md` cannot trigger this behavior by itself; the launcher must implement it.
