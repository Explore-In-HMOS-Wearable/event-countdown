import dayjs from 'dayjs';

const today = new Date();

interface Progress {
  years: number;
  days: number;
  hours: number;
  minutes: number;
  sec: number;
}

function convertMsToDHM(ms): Progress {
  const days = Math.floor(ms / (24 * 60 * 60 * 1000));
  const daysMS = ms % (24 * 60 * 60 * 1000);
  const hours = Math.floor(daysMS / (60 * 60 * 1000));
  const hoursMS = ms % (60 * 60 * 1000);
  const minutes = Math.floor(hoursMS / (60 * 1000));
  const minMs = ms % (60 * 1000);
  const sec = Math.floor(minMs / 1000);
  const years = Math.floor(days / 365);

  return {
    years,
    days,
    hours,
    minutes,
    sec
  }
}

function getMonthDayName(date: Date): { monthName: string; dayName: string; } {
  const monthName = date.toLocaleString('en-US', { month: 'long' })
  const dayName = date.toLocaleString('en-US', { weekday: 'long' })

  return { monthName, dayName }
}

export function formatDate(date: Date): string {
  return dayjs(date).format('DD.MM.YYYY HH:mm')
}

export function getDayProgress(today: Date = new Date()): {
  elapsed: number;
  total: number;
  progress: Progress;
  day: string;
} {
  const start = new Date(today);
  start.setHours(0, 0, 0, 0);

  const end = new Date(today);
  end.setHours(23, 59, 59, 99);

  const elapsed = today.getTime() - start.getTime();
  const total = end.getTime() - start.getTime();

  const elapsedDays = convertMsToDHM(elapsed);
  const totalDays = convertMsToDHM(total);

  return {
    elapsed: elapsedDays.hours,
    total: totalDays.hours,
    progress: elapsedDays,
    day: getMonthDayName(today).dayName
  }
}

export function getMonthProgress(today: Date = new Date()): {
  elapsed: number;
  total: number;
  progress: Progress;
  month: string;
} {
  const start = new Date(today.getFullYear(), today.getMonth(), 1);
  const end = new Date(today.getFullYear(), today.getMonth() + 1, 0, 23, 59, 59, 999);

  const elapsed = today.getTime() - start.getTime();
  const total = end.getTime() - start.getTime();

  const elapsedDays = convertMsToDHM(elapsed);
  const totalDays = convertMsToDHM(total);

  return {
    elapsed: elapsedDays.days + 1,
    total: totalDays.days + 1,
    progress: elapsedDays,
    month: getMonthDayName(today).monthName
  }
}

export function getYearProgress(today: Date = new Date()): {
  elapsed: number;
  total: number;
  progress: Progress;
  year: number;
} {
  const startOfYear = new Date(today.getFullYear(), 0, 1)
  const endOfYear = new Date(today.getFullYear() + 1, 0, 1)

  const elapsed = today.getTime() - startOfYear.getTime();
  const total = endOfYear.getTime() - startOfYear.getTime();

  const elapsedDays = convertMsToDHM(elapsed);
  const totalDays = convertMsToDHM(total);

  return {
    elapsed: elapsedDays.days,
    total: totalDays.days,
    progress: elapsedDays,
    year: today.getFullYear()
  }
}

export function getEventProgress(date: Date): {
  progress: Progress;
  isPassed: boolean;
  total: number;
  elapsed: number;
} {
  const start = new Date(date.getFullYear(), 0, 1);
  let isPassed = false;

  let left = date.getTime() - today.getTime();
  if (left < 0) {
    isPassed = true;
    left = today.getTime() - date.getTime();
  }
  const leftDHM = convertMsToDHM(left);
  const startDHM = convertMsToDHM(today.getTime() - start.getTime());

  let total = 100;
  let elapsed = 100;

  if (!isPassed) {
    if (leftDHM.years > 0) {
      elapsed = leftDHM.years;
      total = leftDHM.years - startDHM.years;
    }
    if (leftDHM.days > 0) {
      elapsed = leftDHM.days;
      total = leftDHM.days - startDHM.days;
    } else if (leftDHM.hours > 0) {
      elapsed = leftDHM.hours;
      total = leftDHM.hours - startDHM.hours;
    } else if (leftDHM.minutes > 0) {
      elapsed = leftDHM.minutes;
      total = leftDHM.minutes - startDHM.minutes;
    } else if (leftDHM.sec > 0) {
      elapsed = leftDHM.sec;
      total = leftDHM.sec - startDHM.sec;
    }
  }

  return {
    progress: leftDHM,
    isPassed,
    total,
    elapsed
  };
}

export function getRandomColor(): string {
  const letters = '0123456789ABCDEF';
  let color = '#';
  for (let index = 0; index < 6; index++) {
    color += letters[Math.floor(Math.random() * letters.length)]
  }
  return color;
}