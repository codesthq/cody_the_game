declare namespace JQueryNiceScroll {
    export interface JQueryNiceScrollOptions {
    }
}
interface JQuery {
    /**
    * Creates a new tinyscrollbar with the specified, or default, options.
    *
    * @param options The options
    */
    niceScroll(options?: JQueryNiceScroll.JQueryNiceScrollOptions): JQuery;

}
