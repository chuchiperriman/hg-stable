
copy: tests/test-copy
copyrev: 33bc9f52ea01abf8ca2cd25eeb9e3cfd0cd4ca37

  $ hg init
  $ echo a > a
  $ hg add a
  $ hg commit -m "1" -d "1000000 0"
  $ hg status
  $ hg copy a b
  $ hg status
  A b
  $ hg sum
  parent: 0:33aaa84a386b tip
   1
  branch: default
  commit: 1 copied
  update: (current)
  $ hg --debug commit -m "2" -d "1000000 0"
  b
   b: copy a:b789fdd96dc2f3bd229c1dd8eedf0fc60e2b68e3
  committed changeset 1:76973b01f66a012648546c979ea4c41de9e7d8cd

we should see two history entries

  $ hg history -v
  changeset:   1:76973b01f66a
  tag:         tip
  user:        test
  date:        Mon Jan 12 13:46:40 1970 +0000
  files:       b
  description:
  2
  
  
  changeset:   0:33aaa84a386b
  user:        test
  date:        Mon Jan 12 13:46:40 1970 +0000
  files:       a
  description:
  1
  
  

we should see one log entry for a

  $ hg log a
  changeset:   0:33aaa84a386b
  user:        test
  date:        Mon Jan 12 13:46:40 1970 +0000
  summary:     1
  

this should show a revision linked to changeset 0

  $ hg debugindex .hg/store/data/a.i
     rev    offset  length   base linkrev nodeid       p1           p2
       0         0       3      0       0 b789fdd96dc2 000000000000 000000000000

we should see one log entry for b

  $ hg log b
  changeset:   1:76973b01f66a
  tag:         tip
  user:        test
  date:        Mon Jan 12 13:46:40 1970 +0000
  summary:     2
  

this should show a revision linked to changeset 1

  $ hg debugindex .hg/store/data/b.i
     rev    offset  length   base linkrev nodeid       p1           p2
       0         0      65      0       1 37d9b5d994ea 000000000000 000000000000

this should show the rename information in the metadata

  $ hg debugdata .hg/store/data/b.d 0 | head -3 | tail -2
  copy: a
  copyrev: b789fdd96dc2f3bd229c1dd8eedf0fc60e2b68e3

  $ $TESTDIR/md5sum.py .hg/store/data/b.i
  4999f120a3b88713bbefddd195cf5133  .hg/store/data/b.i
  $ hg cat b > bsum
  $ $TESTDIR/md5sum.py bsum
  60b725f10c9c85c70d97880dfe8191b3  bsum
  $ hg cat a > asum
  $ $TESTDIR/md5sum.py asum
  60b725f10c9c85c70d97880dfe8191b3  asum
  $ hg verify
  checking changesets
  checking manifests
  crosschecking files in changesets and manifests
  checking files
  2 files, 2 changesets, 2 total revisions
