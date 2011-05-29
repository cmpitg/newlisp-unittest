Introduction
============

``nl-unittest`` is a simple unit testing framework for `newLISP`_, a
modern dialect of `Lisp`_.

Installing
==========

Just load the file: ``nl-unittest.lsp`` in the main directory.

Optional Parameters
===================

* ``unittest:*enable-color*``

  If you want to have colors in VT-100 compatible terminal, set it to
  ``true``, otherwise, set it to ``nil``.  **Default value:** ``true``.

Using
=====

1) First, load the main file ``nl-unittest.lsp``.  You will have a
defined context named ``unittest``.

2) Define a test case with: ``(deftest (test-name params) body*)``.
Remember to have convention for ``test-name`` or you might suffer from
symbols conflicting.

3) Whenever you want to run a test case, call its in exactly the same
way you call function.

4) If you want to run all the test cases at the same time, name the
test with the prefix ``test_`` and call ``(unittest:run-all
context-name)``.

License
=======

See COPYING for more details.

Links
=====

.. _`newLISP`: http://www.newlisp.org
.. _`Lisp`: http://en.wikipedia.org/wiki/Lisp_(programming_language)

.. target-notes::
