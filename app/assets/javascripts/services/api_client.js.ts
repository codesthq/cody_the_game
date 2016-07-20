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

    this.get(path, callback, error);
  }

  getLevel(id: number, callback: SuccessCallback, error: ErrorCallback) {
    var path = [this.ENDPOINT, "levels", id].join("/");

    this.get(path, callback, error);
  }

  getGameSession(callback: SuccessCallback, error: ErrorCallback) {
    var path = [this.ENDPOINT, "game_session"].join("/");

    this.get(path, callback, error);
  }

  submitCode(level_id: number, content: string, callback: SuccessCallback, error: ErrorCallback) {
    var path = [this.ENDPOINT, "submissions"].join("/");
    var data = { submission: { content: content, level_id: level_id } };

    this.post(path, data, callback, error);
  }

  getSubmission(id: number, callback: SuccessCallback, error: ErrorCallback) {
    var path = [this.ENDPOINT, "submissions", id].join("/");

    this.get(path, callback, error);
  }

  private get(path: string, callback: SuccessCallback, error: ErrorCallback) {
    $.ajax({
        type: 'GET',
        url: path,
        timeout: 1000
      })
      .done(callback)
      .fail(error);
  }

  private post(path: string, data: any, callback: SuccessCallback, error: ErrorCallback) {
    $.ajax({
        type: 'POST',
        url: path,
        data: data,
        timeout: 1000
      })
      .done(callback)
      .fail(error);
  }
}
