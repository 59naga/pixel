import pixelUtil from 'pixel-util';
import gif from 'pixel-gif';
import jpg from 'pixel-jpg';
import png from 'pixel-png';
import bmp from 'pixel-bmp';
import { parse as webpParse } from 'pixel-webp';

export default async file => {
  const types = await pixelUtil.detect(file);
  switch (types.ext) {
    case 'gif':
      return gif.parse(file);
    case 'png':
      return png.parse(file);
    case 'jpg':
      return jpg.parse(file);
    case 'bmp':
      return bmp.parse(file);
    case 'webp':
      return webpParse(file);
    default:
      return Promise.reject(new Error(types.ext + ' is Unsupported type.'));
  }
};
