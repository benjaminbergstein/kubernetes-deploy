const fetch = require("node-fetch")
const base64 = require('base-64');
const apiUsername = process.env.NAME_USERNAME

const apiToken = process.env.NAME_API_TOKEN

const encodedAuth = base64.encode(`${apiUsername}:${apiToken}`)
const headers = {
  'Authorization': `Basic ${encodedAuth}`,
}

const api = async (method, path, {
  headers: additionalHeaders,
  ...additionalOptions
} = {}) => fetch(
  `https://api.name.com${path}`,
  {
    method,
    headers: { ...headers, ...additionalHeaders },
    ...additionalOptions,
  },
).catch((e) => {
  console.error("An error occurred: ")
  console.error(e)
})

const post = async (path, json = {}) => api('POST', path, {
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify(json),
})

const getRecord = async (domain, host) => (
  api('GET', `/v4/domains/${domain}/records`)
    .then((res) => res.json())
    .then((res) => {
      const { records } = res

      return records.find(
        ({ host: recordHost }) => recordHost === host
      )
    })
)

const Commands = {
  ['list-records']: async (domain) =>
    api('GET', `/v4/domains/${domain}/records`)
      .then((res) => res.json()),

  ['get-record']: getRecord,

  ['create-record']: async (domain, host, type, answer, ttl = 300) => (
    post(`/v4/domains/${domain}/records`, { host, type, answer, ttl, })
      .then((res) => res.json())
  ),

  ['destroy-record']: async (domain, host) => (
    getRecord(domain, host).then(({ id }) => (
      api('DELETE', `/v4/domains/${domain}/records/${parseInt(id)}`)
        .then((res) => res.json())
    ))
  ),
}

const [commandName, ...commandArgs] = process.argv.slice(2)
const command = Commands[commandName]

command(...commandArgs).then((res) => {
  console.log(JSON.stringify(res))
})
