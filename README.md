## Amazoncorretto Image with non-root user

Non-root user JDK image in runtime. There are various options to be non-root user In this repository, it is switched `1000:1000` by default but also you can specify UID:GID. It creates actual user during bootstrap. So it removes build multiple docker image for permission.

## Non-root user
* User is switched by  [non_root_user_entrypoint.sh](data/non_root_user_entrypoint.sh) with entrypoint
  1. Starting with root user
  1. Running `$ROOT_USER_SCRIPT` if it is passed for root user based setup like changing directory permission, installation package.
  1. Switching to specified user via `$TARGET_UID`/ `$TARGET_GID` or default `1000:1000`
* Non-root user is safety line to protect host machine and middlewares even in container. 
* We also need non-root user to be compatible with host system by match UID/GID like mounting permission
* You can set up non-root user by `user: UID/GID` option in container if your orchestration tool allows it. In this case, 
  * You would lose root user's initialization since you are always not root user
  * You would create various docker image to match UID:GID if deployed environment has various UID:GID rules
    * Complicated host machine not always give you 1000 or 1001 
    * Some application requires actually existing user and group name in container. In this case your docker image should have in advance 