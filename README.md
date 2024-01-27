# Segment Anything Docker

Segment Anything(sam) from https://github.com/facebookresearch/segment-anything

sam can run on devices `cpu` and `cuda`, platforms can be `linux/amd64` and `linux/arm64`.

After searching, there are already other projects covering devices and platforms.

- [waikato-datamining/pytorch](https://github.com/waikato-datamining/pytorch/blob/master/segment-anything/README.md)
    | devices | platforms | model |
    | ----- | ----- | ----- |
    | cpu | linux/amd64 | NOT included |
    | cuda | linux/amd64 | NOT included |

- [dusty-nv/jetson-containers](https://github.com/dusty-nv/jetson-containers/tree/master/packages/vit/sam#user-content-images)
    | devices | platforms | model |
    | ----- | ----- | ----- |
    | _cpu(sameas cuda)_ | _linux/arm64_ | _NOT included_ |
    | cuda | linux/arm64 | NOT included |

## details

This project builds the model in the image,
published on docker hub and ghcr.io.

| devices | platforms | model |
| ----- | ----- | ----- |
| cpu | linux/amd64 | included: vit_h, vit_l, vit_b |
| cpu | linux/arm64 | contains: vit_h, vit_l, vit_b |
| cuda | linux/amd64 | contains: vit_h, vit_l, vit_b |

This project attempts to use `python` base image to build for `cpu` device,
using `nvidia/cuda` base image to build for `cuda` device,
there is no `linux/arm64` platform because pytouch does not provide wheel for `cuda` device.

Tried to build using ngc `nvcr.io/nvidia/pytorch` base image, 
but failed due to github action device space limit.
