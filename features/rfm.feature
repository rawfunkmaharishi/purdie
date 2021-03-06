@clearconf
@vcr
@broken
Feature: First contact with the Real World

  Scenario: Generate YAML for the Raw Funk Maharishi
    Given a file named "_sources/flickr.csv" with:
    """
    https://www.flickr.com/photos/cluttercup/15950875724/
    https://www.flickr.com/photos/cluttercup/16579675721/
    """
    And a file named "_sources/soundcloud.csv" with:
    """
    https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1
    https://soundcloud.com/rawfunkmaharishi/beer-of-course-but-why
    """
    And a file named "_sources/vimeo.csv" with:
    """
    https://vimeo.com/117102891
    https://vimeo.com/110132671
    """
    And a file named "_config/purdie.yaml" with:
    """
    default_title: Raw Funk Maharishi
    """
    When I successfully run `purdie fetch`
    Then a file named "_data/flickr.yaml" should exist
    And the file "_data/flickr.yaml" should contain:
    """
    ---
    - title: Raw Funk Maharishi
      date: '2015-02-18'
      photo_page: https://www.flickr.com/photos/cluttercup/15950875724/
      photo_url: https://farm8.staticflickr.com/7398/15950875724_23d58be214_m.jpg
      license: Attribution-NonCommercial
      license_url: https://creativecommons.org/licenses/by-nc/2.0/
      photographer: cluttercup
    - title: Raw Funk Maharishi
      date: '2015-02-18'
      photo_page: https://www.flickr.com/photos/cluttercup/16579675721/
      photo_url: https://farm8.staticflickr.com/7418/16579675721_f765c42f99_m.jpg
      license: Attribution-NonCommercial
      license_url: https://creativecommons.org/licenses/by-nc/2.0/
      photographer: cluttercup
    """
    And a file named "_data/soundcloud.yaml" should exist
    And the file "_data/soundcloud.yaml" should contain:
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
    """
    And a file named "_data/vimeo.yaml" should exist
    And the file "_data/vimeo.yaml" should contain:
    """
    ---
    - title: Bernard
      id: 117102891
      license: Attribution-NonCommercial-ShareAlike
      license_url: http://creativecommons.org/licenses/by-nc-sa/3.0/
    - title: Discotheque Metamorphosis
      id: 110132671
      license: Attribution-NonCommercial-ShareAlike
      license_url: http://creativecommons.org/licenses/by-nc-sa/3.0/
    """
