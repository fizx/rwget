# RWGet

RWget is a web crawler that tries to emulate a subset of the interface of GNU/Wget, but with more flexibility for my needs.

## Features

1. Regular expression accept/reject lists
2. Pluggable interfaces for robots-txt, url-fetcher, url-queue, url-dupe-detector, and page-storage.  The defaults store locally, and fetch using libcurl, but you could easily change to db storage, a distributed queue, etc.

## Help page

    Usage: /usr/bin/rwget [options] SEED_URL [SEED_URL2 ...]
        -w, --wait=SECONDS               wait SECONDS between retrievals.
        -P, --directory-prefix=PREFIX    save files to PREFIX/...
        -U, --user-agent=AGENT           identify as AGENT instead of RWget/VERSION.
        -A, --accept-pattern=RUBY_REGEX  URLs must match RUBY_REGEX to be saved to the queue.
            --time-limit=AMOUNT          Crawler will stop after this AMOUNT of time has passed.
        -R, --reject-pattern=RUBY_REGEX  URLs must NOT match RUBY_REGEX to be saved to the queue.
            --require=RUBY_SCRIPT        Will execute 'require RUBY_SCRIPT'
            --limit-rate=RATE            limit download rate to RATE.
            --http-proxy=URL             Proxies via URL
            --proxy-user=USER            Sets proxy user to USER
            --proxy-password=PASSWORD    Sets proxy password to PASSWORD
            --fetch-class=RUBY_CLASS     Must implement fetch(uri, user_agent_string) #=> [final_redirected_url, file_object]
            --store-class=RUBY_CLASS     Must implement put(key_string, temp_file)
            --dupes-class=RUBY_CLASS     Must implement dupe?(uri)
            --queue-class=RUBY_CLASS     Must implement put(key_string, depth_int) and get() #=> [key_string, depth_int]
            --links-class=RUBY_CLASS     Must implement urls(base_uri, temp_file) #=> [uri, ...]
        -Q, --quota=NUMBER               set retrieval quota to NUMBER.
            --max-redirect=NUM           maximum redirections allowed per page.
        -H, --span-hosts                 go to foreign hosts when recursive
            --connect-timeout=SECS       set the connect timeout to SECS.
        -T, --timeout=SECS               set all timeout values to SECONDS.
        -l, --level=NUMBER               maximum recursion depth (inf or 0 for infinite).
            --[no-]timestampize          Prepend the timestamp of when the crawl started to the directory structure.
            --incremental-from=PREVIOUS  Build upon the indexing already saved in PREVIOUS.
            --protocol-directories       use protocol name in directories.
            --no-host-directories        don't create host directories.
        -v, --[no-]verbose               Run verbosely
        -h, --help                       Show this message

## Ruby API

    require "rubygems"
    require "rwget"
    
    # options is the same as the command-line long options, but converted into
    # idiomatic ruby.  See the RDoc for details.
    # i.e. 
    # sh$ rwget -T 5 -A ".*foo.*" http://google.com
    # becomes:
    # irb$ RWGet::Controller.new({:seeds => ["http://google.com"], 
    #            :timeout => 5, :accept_patterns => /.*foo.*/}).start
    
    RWGet::Controller.new(options).start