/* kt.cmd */
parse arg argall

say 'Start time =' time()
timeElapsed = time('E')

Address CMD argall

timeElapsed = time('E')

say 'End time =' time()

hours = format( timeElapsed / 3600, 2, 0 )
timeElapsed = timeElapsed - hours * 3600

minutes = format( timeElapsed / 60, 2, 0 )
timeElapsed = timeElapsed - minutes * 60

seconds = format( timeElapsed, 2, 2 )

say 'Elapsed time =',
    translate( hours, '0', ' ') || ':' ||,
    translate( minutes, '0', ' ') || ':' ||,
    translate( seconds, '0', ' ')
