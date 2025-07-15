# Is using POST as the HTTP method for a request more secure than GET? Why or why not?

# No. Any request sent over HTTP is sent simply as plain text regardless of the HTTP
# method used, so if no security measures are in place, POST and GET methods are both
# susceptible to being compromised while being transferred over the network