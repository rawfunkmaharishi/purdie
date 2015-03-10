@vcr
Feature: Soundcloud set

  Scenario: Generate YAML for a SoundCloud set
    Given a file named "_sources/soundcloud-set.csv" with:
    """
    https://soundcloud.com/rawfunkmaharishi/sets/islington-academy-sessions
    """
    When I successfully run `purdie fetch`
  #  Then a file named "_data/soundcloud.yaml" should exist
  #  And the file "_data/soundcloud.yaml" should contain:
  #  """
  #  """
