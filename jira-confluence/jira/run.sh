docker run \
    -d -p  9005:8080 \
    -v $PWD/data:/var/atlassian/jira \
    --name jira  researchboy/jira:v7.12.0
