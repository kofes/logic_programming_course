post_order(nil) --> [].
post_order(btree(Root, LTree, RTree)) -->
        post_order(LTree),
        post_order(RTree),
        [Root].

test0:-
  post_order(nil, L, []),
  L = [].

test1:-
  post_order(btree(root, btree(left, nil, nil), btree(right, nil, nil)), R, []),
  R = [left, right, root].

test2:-
  post_order(
    btree(root,
      btree(left, btree(leftleft, nil, nil), nil),
      btree(right, nil, nil)
    ), R, []),
  R = [leftleft, left, right, root].

test3:-
  post_order(
    btree(root,
      btree(left, btree(leftleft, nil, nil), nil),
      btree(right, nil, btree(rightleft, nil, nil))
    ), R, []),
  R = [leftleft, left, rightleft, right, root].
