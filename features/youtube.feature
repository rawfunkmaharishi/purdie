@vcr
Feature: YouTube

  Scenario: Generate YouTube YAML
    Given a file named "_sources/youtube.movies" with:
    """
    https://www.youtube.com/watch?v=Qt_J0jNqtZg&list=PLuPLM2FI60-M0-aWejF9WgB-Dkt1TuQXv&index=2
    """
    When I successfully run `purdie fetch`
    Then a file named "_data/youtube.yaml" should exist
    And the file "_data/youtube.yaml" should contain:
    """
    - title: Sam Pikesley – Vandalising your Github commit history for fun and profit
      id: Qt_J0jNqtZg
      license: Attribution
      license_url: https://creativecommons.org/licenses/by/3.0/
    """
    And a file named "_data/soundcloud.yaml" should not exist
    And a file named "_data/vimeo.yaml" should not exist
    And a file named "_data/flickr.yaml" should not exist
