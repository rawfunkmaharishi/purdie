@vcr
Feature: Soundcloud set

  Scenario: Generate YAML for a SoundCloud set
    Given a file named "_sources/soundcloud-set.csv" with:
    """
    https://soundcloud.com/rawfunkmaharishi/sets/islington-academy-sessions
    """
    When I successfully run `purdie fetch`
    Then a file named "_data/soundcloud-set.yaml" should exist
    And the file "_data/soundcloud-set.yaml" should contain:
    """
    ---
    - title: Hexaflexagon
      id: 193008299
      location: Islington Academy
      date: '2015-02-18'
      license: Attribution-NonCommercial-ShareAlike
      license_url: http://creativecommons.org/licenses/by-nc-sa/4.0/
    - title: Beer, Of Course, But Why
      id: 193006525
      location: Islington Academy
      date: '2015-02-18'
      license: Attribution-NonCommercial-ShareAlike
      license_url: http://creativecommons.org/licenses/by-nc-sa/4.0/
    - title: Junalbandi
      id: 193005357
      location: Islington Academy
      date: '2015-02-18'
      license: Attribution-NonCommercial-ShareAlike
      license_url: http://creativecommons.org/licenses/by-nc-sa/4.0/
    - title: Bernard
      id: 192841052
      location: Islington Academy
      date: '2015-02-18'
      license: Attribution-NonCommercial-ShareAlike
      license_url: http://creativecommons.org/licenses/by-nc-sa/4.0/
    """
    And a file named "_data/flickr.yaml" should not exist
    And a file named "_data/youtube.yaml" should not exist
    And a file named "_data/vimeo.yaml" should not exist
