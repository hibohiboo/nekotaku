import ListModel from '@/browser/models/ListModel';

async function parseBody(body: string|Object[], dice: ?string): Promise<Object> {
  if (typeof body !== 'string') return body;
  if (dice) {
    const {
      executeDice,
      getDiceBotDescByFilename,
    } = await import(/* webpackChunkName: "bcdice" */ '@/browser/utilities/bcdice');

    const diceBotDesc = getDiceBotDescByFilename(dice);

    const {
      result,
      diceResults,
    } = await executeDice(body, dice);

    return body.split(/\n/g).map(text => ({ type: 'text', text })).concat(result === '1' ? [] : [{
      type: 'dice',
      dice: diceBotDesc ? diceBotDesc.gameType : dice,
      text: result.replace(/^: /, ''),
      diceResults,
    }]);
  }
  return body.split(/\n/g).map(text => ({ type: 'text', text }));
}

export default class MessagesModel extends ListModel {
  constructor(backend) {
    super(backend, 'messages');
  }

  async push(roomId: string, data: Object): Promise<void> {
    const {
      body,
      dice,
      to,
      ...others
    } = data;

    await super.push(roomId, {
      ...others,
      body: await parseBody(body, dice),
      to: (typeof to === 'string' ? to.split(/\s*,\s*/g) : to) || null,
      createdAt: Date.now(),
    });
  }
}
