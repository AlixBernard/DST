#!/bin/env bash



apiKey='cc8b2c70b4c1271b49775b1bf6d27befbc929'

function _req {
	curl -H "accept: application/json" \
		-H "Content-Type: application/json" \
		-H "x-apikey: $apiKey" \
		-X $1 "https://dstnsu-011f.restdb.io/rest/$2"
}


function add-docs {
	curl -H "accept: application/json" \
		-H "Content-Type: application/json" \
		-H "x-apikey: $apiKey" \
		-X POST \
		-d '[
			{"name":"Johnny","lastName":"Dan"}
		]' \
		"https://dstnsu-011f.restdb.io/rest/$2" |
		jq ''
}