
copy: tests/test-mq-caches
copyrev: 71e1dec4f552ea78293c5a9d354807eee60e5f3d

  $ branches=.hg/branchheads.cache
  $ echo '[extensions]' >> $HGRCPATH
  $ echo 'mq =' >> $HGRCPATH

  $ show_branch_cache()
  > {
  >     # force cache (re)generation
  >     hg log -r does-not-exist 2> /dev/null
  >     hg log -r tip --template 'tip: {rev}\n'
  >     if [ -f $branches ]; then
  >       sort $branches
  >     else
  >       echo No branch cache
  >     fi
  >     if [ "$1" = 1 ]; then
  >       for b in foo bar; do
  >         hg log -r $b --template "branch $b: "'{rev}\n'
  >       done
  >     fi
  > }

  $ hg init a
  $ cd a
  $ hg qinit -c


mq patch on an empty repo

  $ hg qnew p1
  $ show_branch_cache
  tip: 0
  No branch cache

  $ echo > pfile
  $ hg add pfile
  $ hg qrefresh -m 'patch 1'
  $ show_branch_cache
  tip: 0
  No branch cache

some regular revisions

  $ hg qpop
  popping p1
  patch queue now empty
  $ echo foo > foo
  $ hg add foo
  $ echo foo > .hg/branch
  $ hg ci -m 'branch foo' -d '1000000 0'

  $ echo bar > bar
  $ hg add bar
  $ echo bar > .hg/branch
  $ hg ci -m 'branch bar' -d '1000000 0'
  $ show_branch_cache
  tip: 1
  3f910abad313ff802d3a23a7529433872df9b3ae 1
  3f910abad313ff802d3a23a7529433872df9b3ae bar
  9539f35bdc80732cc9a3f84e46508f1ed1ec8cff foo

add some mq patches

  $ hg qpush
  applying p1
  now at: p1
  $ show_branch_cache
  tip: 2
  3f910abad313ff802d3a23a7529433872df9b3ae 1
  3f910abad313ff802d3a23a7529433872df9b3ae bar
  9539f35bdc80732cc9a3f84e46508f1ed1ec8cff foo

  $ hg qnew p2
  $ echo foo > .hg/branch
  $ echo foo2 >> foo
  $ hg qrefresh -m 'patch 2'
  $ show_branch_cache 1
  tip: 3
  3f910abad313ff802d3a23a7529433872df9b3ae 1
  3f910abad313ff802d3a23a7529433872df9b3ae bar
  9539f35bdc80732cc9a3f84e46508f1ed1ec8cff foo
  branch foo: 3
  branch bar: 2

removing the cache

  $ rm $branches
  $ show_branch_cache 1
  tip: 3
  3f910abad313ff802d3a23a7529433872df9b3ae 1
  3f910abad313ff802d3a23a7529433872df9b3ae bar
  9539f35bdc80732cc9a3f84e46508f1ed1ec8cff foo
  branch foo: 3
  branch bar: 2

importing rev 1 (the cache now ends in one of the patches)

  $ hg qimport -r 1 -n p0
  $ show_branch_cache 1
  tip: 3
  3f910abad313ff802d3a23a7529433872df9b3ae 1
  3f910abad313ff802d3a23a7529433872df9b3ae bar
  9539f35bdc80732cc9a3f84e46508f1ed1ec8cff foo
  branch foo: 3
  branch bar: 2
  $ hg log -r qbase --template 'qbase: {rev}\n'
  qbase: 1

detect an invalid cache

  $ hg qpop -a
  popping p2
  popping p1
  popping p0
  patch queue now empty
  $ hg qpush -a
  applying p0
  applying p1
  applying p2
  now at: p2
  $ show_branch_cache
  tip: 3
  9539f35bdc80732cc9a3f84e46508f1ed1ec8cff 0
  9539f35bdc80732cc9a3f84e46508f1ed1ec8cff foo

