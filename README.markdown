# RWGet

RWget is a web crawler that tries to emulate a subset of the interface of GNU/Wget, but with more flexibility for my needs.

## Features

1. Regular expression accept/reject lists
2. Pluggable interfaces for robots-txt, url-fetcher, url-queue, url-dupe-detector, and page-storage.  The defaults store locally, and fetch using libcurl, but you could easily change to db storage, a distributed queue, etc.