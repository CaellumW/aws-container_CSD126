1. By port forwarding when ssh'ing into the ec2 instance we're producing a pre-signed URL that allows a user in-direct access to the contents.
2. the GSI's we created are useful to keep track of the photos in our app, and who uploaded it, which are the main functionalities of the app. Of course, the hash keys are incredibly useful being concise and clear about the specific contents it is holding. The range key, or sort , is helpful to ensure that the two GSI's are connected, and not meant to be entirely separate data points

p.s., I don't have anything called photos under flask.