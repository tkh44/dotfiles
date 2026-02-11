# Global Claude Instructions

IMPORTANT: this context may or may not be relevant to your tasks. You should not respond to this context unless it is highly relevant to your task.

## React Query + Connect-Query (Protobuf RPCs)

When using `@bufbuild/connect-query` with `@tanstack/react-query`, the `createUseQueryOptions` helper returns an object with `queryKey`, `queryFn`, etc. You MUST spread it into `useQuery`:

```typescript
// CORRECT - spread the options
const queryOptions = useMemo(() => ({
  ...getRpc.createUseQueryOptions(request, { transport }),
  staleTime,
  enabled,
}), [deps]);

const query = useQuery({
  ...queryOptions,  // <-- SPREAD here
});

// WRONG - this causes "queryKey needs to be an Array" error
const query = useQuery({
  queryKey: queryOptions,  // <-- BUG: passing object as queryKey
});
```

The error message will be: `As of v4, queryKey needs to be an Array. If you are using a string like 'repoData', please change it to an Array`

## Pastry CLI (@instacart/pastry-cli)

Pastry is Instacart's internal CLI for storing and retrieving code snippets via AVA.

**Installation:** `npm install -g @instacart/pastry-cli`

**Commands:**
- `pastry login` - Authenticate with Okta (device flow, opens browser)
- `pastry <slug>` - Retrieve snippet by slug (e.g., `pastry crispy-waffle`)
- `pastry create [name]` - Create snippet from stdin or file
- `pastry list` - Interactive snippet browser
- `pastry auth status` - Check auth state
- `pastry auth clear` - Clear stored credentials

**Examples:**
```bash
pastry crispy-waffle               # Get snippet by slug
pastry create mycode -f script.ts  # Create from file
echo 'hello' | pastry create       # Create from stdin
pastry list                        # Interactive snippet browser
pastry list | head                 # List snippets (non-interactive)
```

**Create options:**
- `-f, --file <path>` - Read content from file
- `-t, --title <title>` - Set snippet title
- `-n, --filename <name>` - Set filename with extension
- `-l, --language <lang>` - Override language detection

**Output behavior:**
- TTY mode: Pretty display with glow/bat/less if available
- Piped mode: Raw content output for scripting

**Auth:** Tokens stored in system keychain. Refresh tokens handled via AVA server.

**Web UI:** When creating or referencing snippets, provide the web link: `https://pastry.instacart.tools/<slug|id>`

**Repo:** https://github.com/instacart/pastry-cli

## ast-grep for Structural Code Search

When code search or refactoring requires understanding code **structure** rather than just text, consider using `ast-grep` (installed at `/opt/homebrew/bin/ast-grep`).

**Proactively suggest `/ast-grep` skill when:**
- User wants to find/replace code patterns across many files
- Search requires understanding syntax (e.g., "find all async functions that...")
- Refactoring involves structural transformations
- grep/ripgrep would produce too many false positives
- User is looking for specific language constructs (function calls, imports, class definitions)

**Quick usage:**
```bash
# Pattern search
ast-grep -p 'console.log($$$)' --lang javascript

# Pattern replace (interactive)
ast-grep -p 'oldApi($ARGS)' -r 'newApi($ARGS)' --interactive

# Debug AST structure
echo 'const x = 1' | ast-grep -p '$$$' --lang js --debug-query=ast
```

**Key principle:** Always use `stopBy: end` in relational rules (`inside`, `has`, `precedes`, `follows`).

For complex rules, invoke `/ast-grep` to get full guidance.

## Chakra UI: Custom Scrollbar Styling

When creating components with internal overflow/scroll (e.g., code blocks, lists, panels), use the custom webkit scrollbar styling for a polished look:

```typescript
/** Custom scrollbar styles for overflow containers */
const scrollbarStyles = {
  '&::-webkit-scrollbar': {
    width: '6px',
    height: '6px',
  },
  '&::-webkit-scrollbar-track': {
    bg: 'transparent',
  },
  '&::-webkit-scrollbar-thumb': {
    bg: 'gray.300',
    borderRadius: 'full',
  },
  '&::-webkit-scrollbar-thumb:hover': {
    bg: 'gray.400',
  },
  _dark: {
    '&::-webkit-scrollbar-thumb': {
      bg: 'gray.600',
    },
    '&::-webkit-scrollbar-thumb:hover': {
      bg: 'gray.500',
    },
  },
};

// Apply via sx prop
<Box overflow="auto" maxH="400px" sx={scrollbarStyles}>
  {/* scrollable content */}
</Box>
```

This provides a thin, rounded scrollbar that adapts to light/dark mode.

## Writing Style: Avoid AI Patterns

**Words/phrases to avoid (AI tells):**
- "Delve", "tapestry", "nuanced", "multifaceted", "landscape"
- "It's worth noting", "It's important to note", "Interestingly"
- "Furthermore", "Moreover", "Additionally" (overuse)
- "In essence", "Ultimately", "Undeniably"
- "On one hand... on the other hand"
- "Let's explore", "Let's dive into"
- "This comprehensive guide", "In this article"
- Excessive hedging: "It could be argued", "One might say"

**Structural patterns to avoid:**
- Rigid intro → 3 points → conclusion formula
- Every paragraph starting with a topic sentence
- Perfectly parallel structure across sections
- Lists that always have exactly 3 items
- Restating the question in the answer
- "In conclusion" or "To summarize" at the end

**Style fixes:**
- Vary sentence length naturally, not mechanically
- Skip the preamble—just answer directly
- Use contractions, be casual where appropriate
- Take actual positions instead of "balanced" non-answers
- Leave things unsaid rather than covering every angle
- Admit uncertainty with "I don't know" vs. hedging phrases
- Use specific details, not generic statements
- Let personality show—quirks, opinions, occasional tangents

**The core fix:** AI writing optimizes for safety, completeness, and formality. Good writing embraces directness, selectivity, and voice.

## Datadog Dashboard & Chart Builder

Use `/datadog` when the user wants to create Datadog dashboards, charts, or visualizations.

**Triggers:**
- "Create a dashboard for..." / "Build me a chart..."
- "I have this Datadog JSON, can you modify it?"
- "Make me an RPM/latency/cost chart"
- "Monitor my [service name]"
- User pastes Datadog chart/dashboard JSON

**What it handles:**
- Building dashboards from scratch based on service/metric names
- Deriving new charts from example JSON
- Creating individual widgets or full dashboards
- Week-over-week comparisons, forecasting, top-N queries
- JSON validation and clipboard copy workflow

**Quick reference - common formulas:**
```
RPM: default_zero(query1) * 60 with .as_rate()
Success %: (query1 / query2) * 100
Week-over-week: week_before(query1)
Forecast: forecast(query1, 'linear', 2)
Top N: top(query1, 4, 'sum', 'desc')
```

See `~/.claude/skills/datadog.md` for full documentation.

## isc-web Monorepo

When running type-check in the isc-web monorepo, always use the workspaces flag:

```bash
npm run type-check --workspaces --if-present
```

This runs type-check only in workspaces that have it defined, avoiding errors from packages without the script.
