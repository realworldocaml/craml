## ocaml-cram: CRAM testing framework

CRAM is a is functional testing framework for command line
applications. `ocaml-cram` is freely inspired by the [Python
tool](https://bitheap.org/cram/), which was itself based on
Mercurial's [unified test
format](https://www.selenic.com/blog/?p=663).

Ocaml-cram is released as a single binary (called `cram`) and
supports the following syntax:

- Lines beginning with two spaces, a dollar sign, and a space are
  *commands* and will be run in the shell.
- Lines beginning with two spaces are considered command *output*.
- Command outputs can contains *ellipsis*: `...`. These will
  match any possible outputs (on zero, one or multiple lines).
- Lines starting by `%%` are command *pre-conditions*; they will
  determine the conditions where the command is run. Currently, only
  non-deterministic modes are supported as pre-conditions (see below).
- Lines starting by `@@` are command *post-conditions*. Currently,
  only exit codes are supported as post-conditions (see below).
- Anything else is a comment.

To run the tests described in a `<file>`, use `cram <file>`. This will
run all the commands in sequence and will generated `<file>.corrected`
if one of the output do not match the expected command outputs.

### Non-deterministic Outputs

Ocaml-cram supports non-deterministic outputs:

```
  $ <command>
%% --non-deterministic
  <output>
```

In that case, `cram <file>` will run the command but will not
generate `<file>.corrected` if the new output differs from the one
described in the file. Use `cram --non-deterministic <file>` to come
back to the default behaviour.

### Non-deterministic Commands

Ocaml-cram supports non-deterministic outputs:

```
  $ <command>
%% --non-deterministic [skip]
  <output>
```

In that case, `cram <file>` will *not* run the command. Use `cram
--non-deterministic <file>` to come back to the default behaviour.

### Exit Codes

Ocaml-cram tests exit codes:

```
  $ <command>
  <output>
@@ exit 10
```

If `<command>` does not exit with code 10, then `cram <file>` will
generate `<file>.corrected` with the right exit code. Note that `@@
exit 0` will not be displayed.
