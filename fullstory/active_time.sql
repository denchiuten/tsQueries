create or replace view fullstory.fullstory_1enq.view_web_pageviews(
    device_id,
    session_id,
    view_id,
    page_definition_id,
    page_definition_name,
    duration_seconds,
    start_time,
    end_time
) as
with web_navigates as (
    select
        e.device_id,
        e.session_id,
        e.view_id,
        e.event_id,
        pd.id as page_definition_id,
        pd.name as page_definition_name,
        event_time as navigate_time,
        nth_value(event_time, 2) over (partition by e.device_id, e.session_id, e.view_id order by e.event_time asc rows between current row and 1 following) as next_navigate_time
    from events as e
    join page_definitions as pd
    on e.source_properties:page_definition_id = pd.id
    where e.event_type = 'navigate'
    and e.source_type = 'web'
), last_events as (
    select wn.event_id, max(e.event_time) last_event_time
    from web_navigates wn
    join events e
    on e.device_id = wn.device_id
    and e.session_id = wn.session_id
    and e.view_id = wn.view_id
    and e.event_time >= wn.navigate_time
    and (wn.next_navigate_time is null or e.event_time < wn.next_navigate_time)
    group by wn.event_id
)
select
    wn.device_id,
    wn.session_id,
    wn.view_id,
    wn.page_definition_id,
    wn.page_definition_name,
    datediff(seconds, wn.navigate_time, le.last_event_time) as duration_seconds,
    wn.navigate_time as start_time,
    le.last_event_time as end_time
from web_navigates as wn
join last_events as le
on wn.event_id = le.event_id
;
