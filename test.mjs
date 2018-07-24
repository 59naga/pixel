import spec from 'eastern';
import assert, { equal } from 'assert';
import fixtures from 'fixture-images';
import pixelUtil from 'pixel-util';
import parse from './';

if (typeof ImageData === 'undefined') {
  global.ImageData = Object;
}

spec('gif: should convert to single imageData', async () => {
  const images = await parse(fixtures.still.gif);
  const expectedData = pixelUtil.createImageData(112, 112);

  equal(images.length, 1);
  assert(images[0] instanceof ImageData);

  equal(images[0].width, expectedData.width);
  equal(images[0].height, expectedData.height);
});

spec('png: should convert to single imageData', async () => {
  const images = await parse(fixtures.still.png);
  const expectedData = pixelUtil.createImageData(96, 96);

  equal(images.length, 1);
  assert(images[0] instanceof ImageData);

  equal(images[0].width, expectedData.width);
  equal(images[0].height, expectedData.height);
});

spec('jpg: should convert to single imageData', async () => {
  const images = await parse(fixtures.still.jpg);
  const expectedData = pixelUtil.createImageData(256, 192);

  equal(images.length, 1);
  assert(images[0] instanceof ImageData);

  equal(images[0].width, expectedData.width);
  equal(images[0].height, expectedData.height);
});

spec('bmp: should convert to single imageData', async () => {
  const images = await parse(fixtures.still.bmp);
  const expectedData = pixelUtil.createImageData(128, 128);

  equal(images.length, 1);
  assert(images[0] instanceof ImageData);

  equal(images[0].width, expectedData.width);
  equal(images[0].height, expectedData.height);
});

spec('webp: should convert to single imageData', async () => {
  const images = await parse(fixtures.still.webp);
  const expectedData = pixelUtil.createImageData(160, 128);

  equal(images.length, 1);
  assert(images[0] instanceof ImageData);

  equal(images[0].width, expectedData.width);
  equal(images[0].height, expectedData.height);
});

spec('gif: should convert to multiple imageData with meta information', async () => {
  const images = await parse(fixtures.animated.gif);

  equal(images.length, 34);
  assert(images[0] instanceof ImageData);

  equal(images[0].width, 73);
  equal(images[0].height, 73);

  // TODO
  // equal(images[0].meta.offset_x, 0);
  // equal(images[0].meta.offset_y, 0);
  // equal(images[0].meta.duration, 1000);
  // equal(images[0].meta.dispose, 0);
  // equal(images[0].meta.blend, 1);
});

spec('png: should convert to multiple imageData with meta information', async () => {
  const images = await parse(fixtures.animated.png);

  equal(images.length, 34);
  assert(images[0] instanceof ImageData);

  equal(images[0].width, 73);
  equal(images[0].height, 73);

  // TODO
  // equal(images[0].meta.offset_x, 0);
  // equal(images[0].meta.offset_y, 0);
  // equal(images[0].meta.duration, 1000);
  // equal(images[0].meta.dispose, 0);
  // equal(images[0].meta.blend, 1);
});

spec('webp: should convert to multiple imageData with meta information', async () => {
  const images = await parse(fixtures.animated.webp);

  equal(images.length, 34);
  assert(images[0] instanceof ImageData);

  equal(images[0].width, 73);
  equal(images[0].height, 73);

  equal(images[0].meta.offset_x, 0);
  equal(images[0].meta.offset_y, 0);
  equal(images[0].meta.duration, 1000);
  equal(images[0].meta.dispose, 0);
  equal(images[0].meta.blend, 1);
});
