
copy: tests/test-debugcomplete
copyrev: 688e5e48c1af1306fc05fe36c36872e06d41c52f

Show all commands except debug commands
  $ hg debugcomplete
  add
  addremove
  annotate
  archive
  backout
  bisect
  branch
  branches
  bundle
  cat
  clone
  commit
  copy
  diff
  export
  forget
  grep
  heads
  help
  identify
  import
  incoming
  init
  locate
  log
  manifest
  merge
  outgoing
  parents
  paths
  pull
  push
  recover
  remove
  rename
  resolve
  revert
  rollback
  root
  serve
  showconfig
  status
  summary
  tag
  tags
  tip
  unbundle
  update
  verify
  version

Show all commands that start with "a"
  $ hg debugcomplete a
  add
  addremove
  annotate
  archive

Do not show debug commands if there are other candidates
  $ hg debugcomplete d
  diff

Show debug commands if there are no other candidates
  $ hg debugcomplete debug
  debugancestor
  debugbuilddag
  debugcheckstate
  debugcommands
  debugcomplete
  debugconfig
  debugdag
  debugdata
  debugdate
  debugfsinfo
  debugindex
  debugindexdot
  debuginstall
  debugpushkey
  debugrebuildstate
  debugrename
  debugrevspec
  debugsetparents
  debugstate
  debugsub
  debugwalk

Do not show the alias of a debug command if there are other candidates
(this should hide rawcommit)
  $ hg debugcomplete r
  recover
  remove
  rename
  resolve
  revert
  rollback
  root
Show the alias of a debug command if there are no other candidates
  $ hg debugcomplete rawc
  

Show the global options
  $ hg debugcomplete --options | sort
  --config
  --cwd
  --debug
  --debugger
  --encoding
  --encodingmode
  --help
  --noninteractive
  --profile
  --quiet
  --repository
  --time
  --traceback
  --verbose
  --version
  -R
  -h
  -q
  -v
  -y

Show the options for the "serve" command
  $ hg debugcomplete --options serve | sort
  --accesslog
  --address
  --certificate
  --config
  --cwd
  --daemon
  --daemon-pipefds
  --debug
  --debugger
  --encoding
  --encodingmode
  --errorlog
  --help
  --ipv6
  --name
  --noninteractive
  --pid-file
  --port
  --prefix
  --profile
  --quiet
  --repository
  --stdio
  --style
  --templates
  --time
  --traceback
  --verbose
  --version
  --web-conf
  -6
  -A
  -E
  -R
  -a
  -d
  -h
  -n
  -p
  -q
  -t
  -v
  -y

Show an error if we use --options with an ambiguous abbreviation
  $ hg debugcomplete --options s
  hg: command 's' is ambiguous:
      serve showconfig status summary

Show all commands + options
  $ hg debugcommands
  add: include, exclude, dry-run
  annotate: rev, follow, no-follow, text, user, file, date, number, changeset, line-number, include, exclude
  clone: noupdate, updaterev, rev, branch, pull, uncompressed, ssh, remotecmd
  commit: addremove, close-branch, include, exclude, message, logfile, date, user
  diff: rev, change, text, git, nodates, show-function, reverse, ignore-all-space, ignore-space-change, ignore-blank-lines, unified, stat, include, exclude
  export: output, switch-parent, rev, text, git, nodates
  forget: include, exclude
  init: ssh, remotecmd
  log: follow, follow-first, date, copies, keyword, rev, removed, only-merges, user, only-branch, branch, prune, patch, git, limit, no-merges, stat, style, template, include, exclude
  merge: force, rev, preview
  pull: update, force, rev, branch, ssh, remotecmd
  push: force, rev, branch, new-branch, ssh, remotecmd
  remove: after, force, include, exclude
  serve: accesslog, daemon, daemon-pipefds, errorlog, port, address, prefix, name, web-conf, webdir-conf, pid-file, stdio, templates, style, ipv6, certificate
  status: all, modified, added, removed, deleted, clean, unknown, ignored, no-status, copies, print0, rev, change, include, exclude
  summary: remote
  update: clean, check, date, rev
  addremove: similarity, include, exclude, dry-run
  archive: no-decode, prefix, rev, type, include, exclude
  backout: merge, parent, rev, include, exclude, message, logfile, date, user
  bisect: reset, good, bad, skip, command, noupdate
  branch: force, clean
  branches: active, closed
  bundle: force, rev, branch, base, all, type, ssh, remotecmd
  cat: output, rev, decode, include, exclude
  copy: after, force, include, exclude, dry-run
  debugancestor: 
  debugbuilddag: mergeable-file, appended-file, overwritten-file, new-file
  debugcheckstate: 
  debugcommands: 
  debugcomplete: options
  debugdag: tags, branches, dots, spaces
  debugdata: 
  debugdate: extended
  debugfsinfo: 
  debugindex: 
  debugindexdot: 
  debuginstall: 
  debugpushkey: 
  debugrebuildstate: rev
  debugrename: rev
  debugrevspec: 
  debugsetparents: 
  debugstate: nodates
  debugsub: rev
  debugwalk: include, exclude
  grep: print0, all, follow, ignore-case, files-with-matches, line-number, rev, user, date, include, exclude
  heads: rev, topo, active, closed, style, template
  help: 
  identify: rev, num, id, branch, tags
  import: strip, base, force, no-commit, exact, import-branch, message, logfile, date, user, similarity
  incoming: force, newest-first, bundle, rev, branch, patch, git, limit, no-merges, stat, style, template, ssh, remotecmd
  locate: rev, print0, fullpath, include, exclude
  manifest: rev
  outgoing: force, rev, newest-first, branch, patch, git, limit, no-merges, stat, style, template, ssh, remotecmd
  parents: rev, style, template
  paths: 
  recover: 
  rename: after, force, include, exclude, dry-run
  resolve: all, list, mark, unmark, no-status, include, exclude
  revert: all, date, rev, no-backup, include, exclude, dry-run
  rollback: dry-run
  root: 
  showconfig: untrusted
  tag: force, local, rev, remove, edit, message, date, user
  tags: 
  tip: patch, git, style, template
  unbundle: update
  verify: 
  version: 

  $ exit 0
