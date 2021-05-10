# syntax=docker/dockerfile:1
FROM bash:latest
ENV NET_CHECKER_INTERVAL=15
CMD ["bash", "/config/net_checker.sh"]