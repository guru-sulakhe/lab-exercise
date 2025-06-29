## Creating an nginx Docker image
* selecting offical nginx image form DockerHub.
* Removing the default index page (index.html) that comes with the Nginx image.
* Deleting the default Nginx config file to replace it with a custom one (.conf).
* Removing the default virtual host configuration from conf.d, avoiding conflicts with your custom config.
* Copying custom Nginx configuration file (roboshop.conf) from the Docker build context into the container.
* Adds local static/ directory (containing HTML, CSS, JS, images, etc.) to the container's web root.
This is what Nginx will serve when users visit the site.


## Orchestrating the nginx image with EKS using Helm
* configmap for storing non-credentials data i..e custom configuration data.
* deployment for Performing Image Upgradation.
* service for Exposing a frontend app to users and Allowing a frontend Pod to talk to a backend Pod


