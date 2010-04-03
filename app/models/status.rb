class Status

    NEW                   = 'New'
    PRELIMINARY_PLACEMENT = 'Preliminary placement'
    FINAL_PLACEMENT       = 'Final placement'

    VALUES = [
        'Declined',
        NEW,
        'Under review',
        'Curator approved',
        'Director approved',
        'Published',
        'Logistics confirmed',
        PRELIMINARY_PLACEMENT,
        FINAL_PLACEMENT,
    ]
    NON_FINAL_VALUES = VALUES - [ PRELIMINARY_PLACEMENT, FINAL_PLACEMENT ]

    #     '-1' => 'Declined',
    #     '0'  => 'New',
    #     '1'  => 'Under review',
    #     '2'  => 'Curator approved',
    #     '3'  => 'Director approved',
    #     '4'  => 'Published',
    #     '5'  => 'Logistics confirmed',
    #     '6'  => 'Preliminary placement',
    #     '7'  => 'Final placement',
    # }
end