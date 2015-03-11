@vcr
Feature: YouTube playlists

  @announce-stdout
  Scenario: Generate YAML for a YouTube playlist
    Given a file named "_sources/youtube" with:
    """
    https://www.youtube.com/playlist?list=PLuPLM2FI60-OIgFTc9YCrGgH5XWGT6znV
    """
    When I successfully run `purdie fetch`
    Then a file named "_data/youtube.yaml" should exist
    And the file "_data/youtube.yaml" should contain:
    """

    """
