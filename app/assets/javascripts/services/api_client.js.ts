/// <reference path='../jquery.d.ts'/>

interface ErrorCallback { (): void };
interface SuccessCallback { (data: any): void };

class APIClient{
  ENDPOINT: string;

  constructor(endpoint: string) {
    this.ENDPOINT = endpoint;
  }

  listLevels(callback: SuccessCallback, error: ErrorCallback) {
    var path = [this.ENDPOINT, "levels"].join("/");

    $.get(path)
      .done(callback)
      .fail(error);
  }

  getLevel(id: number, callback: SuccessCallback, error: ErrorCallback) {
    var path = [this.ENDPOINT, "levels", id].join("/");

    $.get(path)
      .done(callback)
      .fail(error);
  }

  getGameSession(callback: SuccessCallback, error: ErrorCallback) {
    var path = [this.ENDPOINT, "game_session"].join("/");

    $.get(path)
        .done(callback)
        .fail(error);
  }

  submitCode(level_id: number, content: string, callback: SuccessCallback, error: ErrorCallback) {
    var path = [this.ENDPOINT, "submissions"].join("/");

    $.post(path, { submission: { content: content, level_id: level_id } })
      .done(callback)
      .fail(error);
  }

  getSubmission(id: number, callback: SuccessCallback, error: ErrorCallback) {
    var path = [this.ENDPOINT, "submissions", id].join("/");

    $.get(path)
      .done(callback)
      .fail(error);
  }
}
