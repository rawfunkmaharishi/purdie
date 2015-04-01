@vcr
@announce-stdout
Feature: Missing or bad credentials

  Scenario: Attempt to process SoundCloud URLs with missing credentials
    Given a file named "_sources/soundcloud.csv" with:
    """
    https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1
    """
    And no credentials for SoundCloud
    When I run `purdie fetch`
    Then the stderr should contain:
    """
    Missing or duff credentials for: SoundCloud
    """
    And I restore the credentials for SoundCloud

  Scenario: Bad credentials for multiple services
    Given a file named "_sources/sources.sources" with:
    """
    https://vimeo.com/110132671
    https://vimeo.com/110133117
    """
    And no credentials for Vimeo
    And bad credentials for YouTube
    When I run `purdie fetch`
    Then the stderr should contain:
    """
    Missing or duff credentials for: Vimeo
    """
    And I restore the credentials for Vimeo
    And I restore the credentials for YouTube
