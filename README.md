# Mono Issue 9788
Working repo for Mono Issue #9788

See https://github.com/mono/mono/issues/9788

# Notes

GDB
```bash
docker run -d -p 1234:1234 --name foo_bar --cap-add="SYS_PTRACE" -v "${PWD}:/tmp" thebiggerguy/mono-issue-9788 qemu-arm-static -g 1234 /usr/bin/mono /usr/lib/mono/msbuild/15.0/bin/MSBuild.dll
docker run --link=foo_bar -it  thebiggerguy/mono-issue-9788 gdb -ex="target remote foo_bar:1234"
```