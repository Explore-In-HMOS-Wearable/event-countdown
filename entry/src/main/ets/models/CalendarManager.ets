import { calendarManager } from '@kit.CalendarKit';
import GlobalContext from './GlobalContext';

export default class CalendarManager {
  private static instance: CalendarManager;
  private calendarManager: calendarManager.CalendarManager | null = null;

  constructor(calendarManager: calendarManager.CalendarManager) {
    this.calendarManager = calendarManager;
  }

  static getInstance(): CalendarManager {
    if (!CalendarManager.instance) {
      const context = GlobalContext.getInstance().getContext();
      let manager = calendarManager.getCalendarManager(context);
      CalendarManager.instance = new CalendarManager(manager);
    }

    return CalendarManager.instance;
  }

  async getCalendar(): Promise<calendarManager.Calendar | undefined> {
    try {
      return await this.calendarManager?.getCalendar();
    } catch (err) {
      console.error(`Failed to get calendar. Code: ${err.code}, message: ${err.message}`);
    }
    ;
    return undefined;
  }
}