# Spaceship Prompt Config
# Uncomment sections you want to show

SPACESHIP_PROMPT_ORDER=(
  # time           # Time stamps section
  # user           # Username section
  dir            # Current directory section
  # host           # Hostname section
  git            # Git section (git_branch + git_status)
  # hg             # Mercurial section
  # package        # Package version
  # node           # Node.js section
  # bun            # Bun section
  # deno           # Deno section
  # ruby           # Ruby section
  # python         # Python section
  # elm            # Elm section
  # elixir         # Elixir section
  # xcode          # Xcode section
  # swift          # Swift section
  # golang         # Go section
  # perl           # Perl section
  # php            # PHP section
  # rust           # Rust section
  # haskell        # Haskell Stack section
  # scala          # Scala section
  # kotlin         # Kotlin section
  # java           # Java section
  # lua            # Lua section
  # dart           # Dart section
  # julia          # Julia section
  # crystal        # Crystal section
  # docker         # Docker section
  # docker_compose # Docker compose section
  # aws            # Amazon Web Services section
  # gcloud         # Google Cloud Platform section
  # azure          # Azure section
  venv           # virtualenv section
  # conda          # conda virtualenv section
  # dotnet         # .NET section
  # ocaml          # OCaml section
  # vlang          # V section
  # zig            # Zig section
  # purescript     # PureScript section
  # erlang         # Erlang section
  # kubectl        # Kubectl context section
  # ansible        # Ansible section
  # terraform      # Terraform workspace section
  # pulumi         # Pulumi stack section
  # nix_shell      # Nix shell
  # exec_time      # Execution time
  # async          # Async jobs indicator
  line_sep       # Line break
  # battery        # Battery level and status
  # jobs           # Background jobs indicator
  # exit_code      # Exit code section
  # sudo           # Sudo indicator
  char           # Prompt character
)

# Directory
SPACESHIP_DIR_TRUNC=1          # Only show current folder name
SPACESHIP_DIR_TRUNC_REPO=true

# Git
SPACESHIP_GIT_PREFIX=""
SPACESHIP_GIT_BRANCH_PREFIX=""
SPACESHIP_GIT_STATUS_SHOW=false

# Prompt character
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "

# Explicitly disable noisy sections
SPACESHIP_NODE_SHOW=false
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_DOCKER_COMPOSE_SHOW=false
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_BUN_SHOW=false
