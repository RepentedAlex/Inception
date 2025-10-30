# Script tips

- `set -e` is used to exit immediately if ANY command fails, so we don't
have our container running a broken configuration.

> ```bash
> #!/bin/bash
> set -e
> mkdir /some/dir
> chown www-data /some/dir
> nginx -g "daemon off;"
> ```

- `set -x` is used to print each command before executing it. It's useful when
debugging/developing but can (and honestly, should) be removed when in
production environment.

- `exec` is used to run a command in the current process, it replaces
the executable using PID 1. A Docker container will run as long as
PID 1 is alive.

> ```bash
> # WITHOUT exec (BAD):
> #!/bin/sh
> nginx -g "daemon off;"
> # Process tree:
> # PID 1: /bin/sh /bin/nginx-launch
> #   └─ PID 42: nginx -g daemon off;
> 
> # WITH exec (GOOD):
> #!/bin/sh
> exec nginx -g "daemon off;"
> # Process tree:
> # PID 1: nginx -g daemon off;
> ```

- nginx doesn't expand environment variables, so we can use (amongst others)
`sed` to expand the environment variables.

> ```nginx
> server_name $DOMAIN; # nginx will not expand this
> ```
> ```bash
> sed -i /path/to/nginx.conf -e 's/#SERVER_NAME_HERE#/server_name'"$DOMAIN www.$DOMAIN"/;
> ```

- Why have a resolver ?

