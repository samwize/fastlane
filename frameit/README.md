** This is a fork of [fastlane/frameit](https://github.com/fastlane/fastlane/frameit).**

## Changes in samwize's fork

- Added iPhone 4 device frame (vertical only) in `devices_frames` since Apple does not provide it
- Support frameless screenshots
- Have `padding_factor` which is a ratio of padding to screen height. Using `padding_factor` will have better layout than using a fixed `padding`, especially for iPad.

## Frameless Screenshots

Sometimes, you want a mix of screenshots with frames and without frames.

By default frames will be applied.

To have frameless, in Framefile.json, set `frame` to `false`. You will also need to set `padding` to 0 and the title to "".

    {
      "filter": "frameless",
      "frame": false,
      "padding": 0
    },

## Using padding_factor

When using `padding_factor`, do not use `padding`.

The default is 0.055. You can change by setting in Framefile.json.

    "default": {
      "padding-factor": 0.07
    }
