package skip.week.calendar

import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.unit.dp
import com.kizitonwose.calendar.compose.WeekCalendar
import com.kizitonwose.calendar.compose.weekcalendar.rememberWeekCalendarState
import com.kizitonwose.calendar.core.atStartOfMonth
import com.kizitonwose.calendar.core.firstDayOfWeekFromLocale
import java.time.LocalDate
import java.time.YearMonth
import java.time.ZoneId
import java.util.Date
import androidx.compose.runtime.LaunchedEffect

@Composable
fun WeekCalendarAndroid(
	selection: Date?,
    content: @Composable (isSelected: Boolean, isToday: Boolean, date: Date, onTap: () -> Unit) -> Unit
) {
    val currentDate = remember { LocalDate.now() }
    val currentMonth = remember { YearMonth.now() }
    val startDate = remember { currentMonth.minusMonths(100).atStartOfMonth() }
    val endDate = remember { currentMonth.plusMonths(100).atEndOfMonth() }
    val firstDayOfWeek = remember { firstDayOfWeekFromLocale() }

    var selectedDay by remember { mutableStateOf(
		selection?.toInstant()?.atZone(ZoneId.systemDefault())?.toLocalDate() ?: currentDate
	) }

	LaunchedEffect(selection) {
		selection?.let {
			selectedDay = it.toInstant().atZone(ZoneId.systemDefault()).toLocalDate()
		}
	}

    val state = rememberWeekCalendarState(
        startDate = startDate,
        endDate = endDate,
        firstVisibleWeekDate = currentDate,
        firstDayOfWeek = firstDayOfWeek
    )

    WeekCalendar(
        state = state,
        contentPadding = androidx.compose.foundation.layout.PaddingValues(start = 15.dp, end = 15.dp),
        dayContent = {
            content(
                it.date == selectedDay,
                it.date == currentDate,
                Date.from(it.date.atStartOfDay(ZoneId.systemDefault()).toInstant())
            ) {
                selectedDay = it.date
            }
        }
    )
}

