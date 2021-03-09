FROM arvacims/hoverfly:1.3.1
ENTRYPOINT ["env"]
CMD exec /bin/hoverfly -pp ${HOVERFLY_PORT_WEB:-8080} -ap ${HOVERFLY_PORT_ADMIN:-8888} -listen-on-host 0.0.0.0 -webserver
