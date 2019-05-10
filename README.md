# Logcli

logcli is tool for easy working with logs but its opionated my work flow to working with logs looks like
fetch json logs from lines and than push it to elasticsearch for future analytics my logs stored
as JSON objects. Example how my logs look like
```text
I, [2019-05-09T17:00:16.049805 #57671]  INFO -- : {"evt_type":"FileUpload":"info","time":"2019-05-09T15:00:16+0000","payload":{"time_elapsed_human":"00:00:00.874","time_elapsed":0.874553},"trace_id":"cd5916a6-14b7-4628-bdda-334e4285a4e0"}
```
as you can see there a log prefixer like `I, [2019-05-09T17:00:16.049805 #57671]  INFO -- : `
that's why its not a JSON but than goes a JSON object that I want to extract
I'm using this command to extract JSON from log line
```bash
logcli extract_json --filenames=log1.log log2.log
```

as result tool create in the SAME directory files with names `log1_json.log, log2_json.log`

than I'm push data to ES for analytics using ES + Kibana

```bash
logcli elasticsearch --filenames=events_json.log --elasticsearch_url=http://localhost:9201
```

```bash
logcli --help #for more command line options
```

tool using batch API and push 100 records and the time

Pretty dummy stuff hah

## Development

In active - passive development

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/logcli. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Logcli project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/logcli/blob/master/CODE_OF_CONDUCT.md).
