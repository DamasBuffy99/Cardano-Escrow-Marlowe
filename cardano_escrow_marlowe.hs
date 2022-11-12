When
    [Case
        (Deposit
            (Role "seller")
            (Role "buyer")
            (Token "" "")
            (ConstantParam "price")
        )
        (When
            [Case
                (Choice
                    (ChoiceId
                        "buyer_confirms_deal"
                        (Role "buyer")
                    )
                    [Bound 0 0]
                )
                Close , Case
                (Choice
                    (ChoiceId
                        "report_problem"
                        (Role "buyer")
                    )
                    [Bound 1 1]
                )
                (Pay
                    (Role "seller")
                    (Account (Role "buyer"))
                    (Token "" "")
                    (ConstantParam "price")
                    (When
                        [Case
                            (Choice
                                (ChoiceId
                                    "confirm_problem"
                                    (Role "seller")
                                )
                                [Bound 1 1]
                            )
                            Close , Case
                            (Choice
                                (ChoiceId
                                    "dispute_problem"
                                    (Role "seller")
                                )
                                [Bound 0 0]
                            )
                            (When
                                [Case
                                    (Choice
                                        (ChoiceId
                                            "dismiss_claim"
                                            (Role "mediator")
                                        )
                                        [Bound 0 0]
                                    )
                                    (Pay
                                        (Role "buyer")
                                        (Party (Role "seller"))
                                        (Token "" "")
                                        (ConstantParam "price")
                                        Close 
                                    ), Case
                                    (Choice
                                        (ChoiceId
                                            "confirm_problem"
                                            (Role "mediator")
                                        )
                                        [Bound 1 1]
                                    )
                                    Close ]
                                (TimeParam "mediation_deadline")
                                Close 
                            )]
                        (TimeParam "dispute_response_deadlin")
                        Close 
                    )
                )]
            (TimeParam "dispute_deadline")
            Close 
        )]
    (TimeParam "payment_deadline")
    Close