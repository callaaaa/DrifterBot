# Introduction

This folder contains the scripts to pre-processes the collected data for further analyses.
Scripts and notebooks in the `exps` folder depends on the results generated by the scripts here.

# Instructions

Modify `metric_job.py` to run various tasks.

## Daily Cron Job

To fetche tweets from connections of bots.
Please set the activation time out of the bot activation time range to avoid Twitter API rate limit.

```python
BOTS = ['your_bot_screen_name']
analyzer = Analyzer()
analyzer.FetchConnTweets(BOTS)
```
## Compute Metric scores for each tweet

### Build resolved_urls in Tweet table.

It must be called before computing url-based political valence scores.

```python
resolve_url.get_expanded_url()
```

### Computes url-based score for each tweet

```python
analyzer = Analyzer()
analyzer.ComputeURLTweetScore()
```

### Computes hashtag-based score for each tweet

```python
analyzer = Analyzer()
analyzer.ComputeHashTagTweetScore()
```

### Computes low credibility score for each tweet

```python
analyzer = Analyzer()
analyzer.ComputeLowCredTweetScore()
```